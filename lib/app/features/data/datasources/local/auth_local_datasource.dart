import 'package:movie_app/app/features/data/models/auth/auth_user_model.dart';
import 'package:movie_app/core/logger/app_logger.dart';
import 'package:movie_app/core/storage/hive/hive.dart';

abstract class AuthLocalDatasource {
  Future<void> login();
  Future<void> logout();
  bool isLoginStatus();
  Future<void> saveToken(String token);
  String getToken();
  Future<void> deleteToken();
  Future<void> saveUser(AuthUserModel user);
  AuthUserModel getUser();
  Future<void> deleteUser();
  Future<void> saveProfilePhotoUrl(String url, String userId);
  String getProfilePhotoUrl(String userId);
  Future<void> clearAllData();
  bool isTokenValid();
  Future<void> refreshToken(String newToken);
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  @override
  Future<void> login() async {
    try {
      await isLoginBox.put('isLogin', true);
    } catch (e) {
      AppLogger.instance.error("$runtimeType login() ${e.toString()}");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await isLoginBox.put('isLogin', false);
      await _secureDeleteToken();
    } catch (e) {
      AppLogger.instance.error("$runtimeType logout() ${e.toString()}");
    }
  }

  @override
  bool isLoginStatus() {
    try {
      return isLoginBox.get('isLogin', defaultValue: false) ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      if (!_isValidToken(token)) {
        throw Exception('Invalid token format');
      }

      await tokenBox.put('token', token);
      await tokenBox.put(
        'token_timestamp',
        DateTime.now().millisecondsSinceEpoch.toString(),
      );
      AppLogger.instance.log(
        "$runtimeType saveToken() SUCCESS - Token securely saved",
      );
    } catch (e) {
      AppLogger.instance.error("$runtimeType saveToken() ${e.toString()}");
      rethrow;
    }
  }

  @override
  String getToken() {
    try {
      final token = tokenBox.get('token', defaultValue: '') ?? '';

      if (!_isValidToken(token)) {
        AppLogger.instance.error(
          "$runtimeType getToken() - Invalid token detected",
        );
        return '';
      }

      return token;
    } catch (e) {
      AppLogger.instance.error("$runtimeType getToken() ${e.toString()}");
      return '';
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _secureDeleteToken();
      AppLogger.instance.log(
        "$runtimeType deleteToken() SUCCESS - Token securely deleted",
      );
    } catch (e) {
      AppLogger.instance.error("$runtimeType deleteToken() ${e.toString()}");
    }
  }

  @override
  Future<void> saveUser(AuthUserModel user) async {
    try {
      await userBox.put('user', user);
    } catch (e) {
      AppLogger.instance.error("$runtimeType saveUser() ${e.toString()}");
    }
  }

  @override
  AuthUserModel getUser() {
    try {
      return userBox.get('user', defaultValue: const AuthUserModel()) ??
          const AuthUserModel();
    } catch (e) {
      AppLogger.instance.error("$runtimeType getUser() ${e.toString()}");
      return const AuthUserModel();
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await userBox.delete('user');
    } catch (e) {
      AppLogger.instance.error("$runtimeType deleteUser() ${e.toString()}");
    }
  }

  @override
  Future<void> saveProfilePhotoUrl(String url, String userId) async {
    try {
      await profilePhotoBox.put('profilePhotoUrl_$userId', url);
    } catch (e) {
      AppLogger.instance.error(
        "$runtimeType saveProfilePhotoUrl() " + e.toString(),
      );
    }
  }

  @override
  String getProfilePhotoUrl(String userId) {
    try {
      return profilePhotoBox.get('profilePhotoUrl_$userId', defaultValue: '') ??
          '';
    } catch (e) {
      AppLogger.instance.error(
        "$runtimeType getProfilePhotoUrl() " + e.toString(),
      );
      return '';
    }
  }

  @override
  Future<void> clearAllData() async {
    try {
      await isLoginBox.clear();
      await _secureDeleteToken();
      await userBox.clear();
      AppLogger.instance.log("$runtimeType clearAllData() SUCCESS");
    } catch (e) {
      AppLogger.instance.error("$runtimeType clearAllData() ${e.toString()}");
    }
  }

  @override
  bool isTokenValid() {
    try {
      final token = getToken();
      if (token.isEmpty) return false;

      if (!_isValidToken(token)) return false;

      final timestampStr =
          tokenBox.get('token_timestamp', defaultValue: '0') ?? '0';
      final timestamp = int.tryParse(timestampStr) ?? 0;
      final tokenAge = DateTime.now().millisecondsSinceEpoch - timestamp;
      final maxAge = 24 * 60 * 60 * 1000; // 24 saat

      if (tokenAge > maxAge) {
        AppLogger.instance.error("$runtimeType isTokenValid() - Token expired");
        return false;
      }

      return true;
    } catch (e) {
      AppLogger.instance.error("$runtimeType isTokenValid() ${e.toString()}");
      return false;
    }
  }

  @override
  Future<void> refreshToken(String newToken) async {
    try {
      await saveToken(newToken);
      AppLogger.instance.log("$runtimeType refreshToken() SUCCESS");
    } catch (e) {
      AppLogger.instance.error("$runtimeType refreshToken() ${e.toString()}");
      rethrow;
    }
  }

  Future<void> _secureDeleteToken() async {
    try {
      await tokenBox.delete('token');
      await tokenBox.delete('token_timestamp');
      await tokenBox.clear();
    } catch (e) {
      AppLogger.instance.error(
        "$runtimeType _secureDeleteToken() ${e.toString()}",
      );
    }
  }

  bool _isValidToken(String token) {
    if (token.isEmpty) return false;

    final parts = token.split('.');
    if (parts.length != 3) return false;

    try {
      for (final part in parts) {
        if (part.isEmpty) return false;
        final decoded = Uri.decodeFull(part);
        if (decoded.isEmpty) return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
