import 'package:dio/dio.dart';
import 'package:movie_app/core/storage/hive/hive.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor() : super();

  // CSRF token son güncelleme zamanını takip etmek için
  static DateTime? _lastCsrfTokenUpdate;
  static const Duration _csrfTokenRefreshInterval = Duration(minutes: 15);
  static bool _isRefreshing =
      false; // Aynı anda birden fazla refresh önlemek için

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print('🔐 AUTH DEBUG: Request path: ${options.path}');

    if (options.path.contains('login') || options.path.contains('register')) {
      print(
        '🔐 AUTH DEBUG: Login/Register endpoint - auth headers will not be added',
      );
      handler.next(options);
      csrfTokenBox.clear();
      sessionIdBox.clear();
      _lastCsrfTokenUpdate = null;
      return;
    }

    var token = tokenBox.get('token') ?? '';
    var csrfToken = csrfTokenBox.get('csrfToken') ?? '';
    var sessionId = sessionIdBox.get('sessionId') ?? '';

    print('🔐 AUTH DEBUG: Has token: ${token.isNotEmpty}');
    print('🔐 AUTH DEBUG: Has csrfToken: ${csrfToken.isNotEmpty}');
    print('🔐 AUTH DEBUG: Has sessionId: ${sessionId.isNotEmpty}');

    if (token.isNotEmpty) {
      // CSRF token kontrolü ve yenileme
      bool shouldRefreshToken = _shouldRefreshCsrfToken(csrfToken);

      if (shouldRefreshToken && !_isRefreshing) {
        print(
          '🔐 AUTH DEBUG: CSRF token needs refresh, attempting to refresh...',
        );
        await _refreshCsrfToken(options);
        csrfToken = csrfTokenBox.get('csrfToken') ?? '';
        sessionId = sessionIdBox.get('sessionId') ?? '';
      }

      options.headers['X-CSRFToken'] = csrfToken;
      options.headers['accept'] = 'application/json';
      options.headers['Cookie'] = 'sessionid=$sessionId';
      options.headers['Authorization'] = 'Bearer $token';

      print('🔐 AUTH DEBUG: Headers added');
      print(
        '🔐 AUTH DEBUG: Authorization: Token ${token.substring(0, token.length > 10 ? 10 : token.length)}...',
      );
      print(
        '🔐 AUTH DEBUG: X-CSRFToken: ${csrfToken.substring(0, csrfToken.length > 10 ? 10 : csrfToken.length)}...',
      );
      print(
        '🔐 AUTH DEBUG: Cookie: sessionid=${sessionId.substring(0, sessionId.length > 10 ? 10 : sessionId.length)}...',
      );
    } else {
      print('🔐 AUTH DEBUG: Token is empty - headers are not added');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final cookies = response.headers['set-cookie'];

    if (cookies != null && cookies.isNotEmpty) {
      bool tokenUpdated = false;

      for (var cookie in cookies) {
        if (cookie.contains('csrftoken=')) {
          final newCsrfToken = _extractCookieValue(cookie, 'csrftoken=') ?? '';
          if (newCsrfToken.isNotEmpty) {
            csrfTokenBox.put('csrfToken', newCsrfToken);
            _lastCsrfTokenUpdate = DateTime.now();
            tokenUpdated = true;
            print('🔐 AUTH DEBUG: CSRF token updated from response');
          }
        }

        if (cookie.contains('sessionid=')) {
          final newSessionId = _extractCookieValue(cookie, 'sessionid=') ?? '';
          if (newSessionId.isNotEmpty) {
            sessionIdBox.put('sessionId', newSessionId);
            print('🔐 AUTH DEBUG: Session ID updated from response');
          }
        }
      }

      if (tokenUpdated) {
        print(
          '🔐 AUTH DEBUG: Token update time recorded: $_lastCsrfTokenUpdate',
        );
      }
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 403 hatası CSRF token problemi olabilir
    if (err.response?.statusCode == 403) {
      print(
        '🔐 AUTH DEBUG: 403 error - CSRF token might be invalid, clearing...',
      );
      csrfTokenBox.clear();
      _lastCsrfTokenUpdate = null;
    }
    handler.next(err);
  }

  /// CSRF token'ın yenilenmesi gerekip gerekmediğini kontrol eder
  bool _shouldRefreshCsrfToken(String currentToken) {
    // Token boşsa kesinlikle yenile
    if (currentToken.isEmpty) {
      print('🔐 AUTH DEBUG: CSRF token is empty');
      return true;
    }

    // Son güncelleme zamanı yoksa yenile
    if (_lastCsrfTokenUpdate == null) {
      print('🔐 AUTH DEBUG: No last update time recorded');
      return true;
    }

    // Belirli bir süre geçtiyse yenile
    final now = DateTime.now();
    final timeSinceLastUpdate = now.difference(_lastCsrfTokenUpdate!);

    if (timeSinceLastUpdate > _csrfTokenRefreshInterval) {
      print(
        '🔐 AUTH DEBUG: CSRF token expired (${timeSinceLastUpdate.inMinutes} minutes old)',
      );
      return true;
    }

    return false;
  }

  /// CSRF token'ı yenilemek için farklı endpoint'leri dener
  Future<void> _refreshCsrfToken(RequestOptions originalOptions) async {
    if (_isRefreshing) {
      print('🔐 AUTH DEBUG: Already refreshing, skipping...');
      return;
    }

    _isRefreshing = true;

    try {
      print('🔐 AUTH DEBUG: Refreshing CSRF token...');

      final dio = Dio();
      dio.options.baseUrl = originalOptions.baseUrl;

      // Önce hafif bir endpoint dene (varsa)
      final endpoints = [
        '/accounts/api/who-am-i/', // Hafif endpoint
        '/auth/profile/', // Auth profile endpoint
        '/core/api/', // Core API endpoint
      ];

      Response? response;

      for (String endpoint in endpoints) {
        try {
          print('🔐 AUTH DEBUG: Trying endpoint: $endpoint');
          response = await dio.get(
            endpoint,
            options: Options(
              headers: {
                'Authorization': 'Token ${tokenBox.get('token') ?? ''}',
                'accept': 'application/json',
              },
            ),
          );

          // Başarılı response alındıysa döngüden çık
          if (response.statusCode == 200) {
            print('🔐 AUTH DEBUG: Successfully got response from: $endpoint');
            break;
          }
        } catch (e) {
          print('🔐 AUTH DEBUG: Failed to get CSRF from $endpoint: $e');
          continue; // Bir sonraki endpoint'i dene
        }
      }

      // Response'dan CSRF token'ı çıkar
      if (response != null) {
        final cookies = response.headers['set-cookie'];
        if (cookies != null && cookies.isNotEmpty) {
          bool tokenFound = false;

          for (var cookie in cookies) {
            if (cookie.contains('csrftoken=')) {
              final newCsrfToken =
                  _extractCookieValue(cookie, 'csrftoken=') ?? '';
              if (newCsrfToken.isNotEmpty) {
                csrfTokenBox.put('csrfToken', newCsrfToken);
                _lastCsrfTokenUpdate = DateTime.now();
                tokenFound = true;
                print('🔐 AUTH DEBUG: CSRF token refreshed successfully');
              }
            }

            if (cookie.contains('sessionid=')) {
              final newSessionId =
                  _extractCookieValue(cookie, 'sessionid=') ?? '';
              if (newSessionId.isNotEmpty) {
                sessionIdBox.put('sessionId', newSessionId);
                print('🔐 AUTH DEBUG: Session ID refreshed successfully');
              }
            }
          }

          if (!tokenFound) {
            print('🔐 AUTH DEBUG: No CSRF token found in response cookies');
          }
        } else {
          print('🔐 AUTH DEBUG: No cookies found in response');
        }
      }
    } catch (e) {
      print('🔐 AUTH DEBUG: Failed to refresh CSRF token: $e');
      // Hata durumunda mevcut token'ı temizle ki bir sonraki istekte tekrar denensin
      if (e is DioException && e.response?.statusCode == 401) {
        print('🔐 AUTH DEBUG: 401 error during refresh - clearing tokens');
        csrfTokenBox.clear();
        sessionIdBox.clear();
        tokenBox.clear();
        _lastCsrfTokenUpdate = null;
      }
    } finally {
      _isRefreshing = false;
    }
  }

  String? _extractCookieValue(String cookie, String prefix) {
    final startIndex = cookie.indexOf(prefix) + prefix.length;
    final endIndex = cookie.indexOf(';', startIndex);

    if (startIndex >= prefix.length && endIndex > startIndex) {
      return cookie.substring(startIndex, endIndex);
    }

    if (startIndex >= prefix.length && endIndex == -1) {
      return cookie.substring(startIndex);
    }

    return null;
  }
}
