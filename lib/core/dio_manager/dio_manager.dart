import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/core/dio_manager/interceptors/error_logging_interceptor.dart';
import 'package:movie_app/core/logger/app_logger.dart';
import 'dart:typed_data';

import 'api_error_model.dart';
import 'api_response_model.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/cache_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class DioApiManager {
  final Dio _dio;

  DioApiManager({required String baseUrl})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.addAll([
      if (kDebugMode)
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          requestHeader: true,
        ),
      AuthInterceptor(),
      RetryInterceptor(dio: _dio), // Auth retry management
      ErrorLoggingInterceptor(), // Error logging
      CacheInterceptor(),
    ]);
  }

  /// GET request for any model type
  Future<ApiResponseModel<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Options? options,
    Map<String, dynamic>? data,
    T Function(dynamic data)? converter,
  }) async {
    return _request<T>(
      _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: options,
        data: data,
      ),
      converter: converter,
      endpoint: endpoint,
    );
  }

  /// POST request for any model type
  Future<ApiResponseModel<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    Options? options,
    T Function(dynamic data)? converter,
  }) async {
    return _request<T>(
      _dio.post(endpoint, data: data, options: options),
      converter: converter,
      endpoint: endpoint,
    );
  }

  /// PUT request for any model type
  Future<ApiResponseModel<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    Options? options,
    T Function(dynamic data)? converter,
  }) async {
    return _request<T>(
      _dio.put(endpoint, data: data, options: options),
      converter: converter,
      endpoint: endpoint,
    );
  }

  /// PATCH request for any model type
  Future<ApiResponseModel<T>> patch<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    Options? options,
    T Function(dynamic data)? converter,
  }) async {
    return _request<T>(
      _dio.patch(endpoint, data: data, options: options),
      converter: converter,
      endpoint: endpoint,
    );
  }

  /// DELETE request for any model type
  Future<ApiResponseModel<T>> delete<T>(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Options? options,
    T Function(dynamic data)? converter,
  }) async {
    return _request<T>(
      _dio.delete(endpoint, queryParameters: queryParams, options: options),
      converter: converter,
      endpoint: endpoint,
    );
  }

  /// POST request with FormData for file uploads
  Future<ApiResponseModel<T>> postFormData<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? files,
    Options? options,
    T Function(dynamic data)? converter,
  }) async {
    FormData formData = FormData.fromMap({
      if (data != null) ...data,
      if (files != null)
        ...files.map((key, value) {
          if (value is Uint8List) {
            return MapEntry(
              key,
              MultipartFile.fromBytes(value, filename: '$key.png'),
            );
          }
          return MapEntry(key, value);
        }),
    });

    return _request<T>(
      _dio.post(endpoint, data: formData, options: options),
      converter: converter,
      endpoint: endpoint,
    );
  }

  /// Centralized request handling with model conversion
  Future<ApiResponseModel<T>> _request<T>(
    Future<Response> request, {
    T Function(dynamic data)? converter,
    required String endpoint,
  }) async {
    try {
      final response = await request;
      if (converter != null) {
        final T model = converter(response.data);
        return ApiResponseModel.success(model);
      } else {
        return ApiResponseModel.success(response.data);
      }
    } on DioException catch (e) {
      AppLogger.instance.error(
        "DioException: ${e.message}",
        error: e.error,
        stackTrace: e.stackTrace,
      );
      return ApiResponseModel.error(_handleDioError(e));
    } catch (e) {
      AppLogger.instance.error("DioException: $e");
      return ApiResponseModel.error(
        ApiErrorModel(message: "Unexpected error occurred."),
      );
    }
  }

  /// Handle DioError and map to ApiError
  ApiErrorModel _handleDioError(DioException e) {
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          return ApiErrorModel(
            message: "Bad request. Please check your data.",
            statusCode: e.response?.statusCode,
          );
        case 401:
          return ApiErrorModel(
            message: "Unauthorized. Please login again.",
            statusCode: e.response?.statusCode,
          );
        case 403:
          return ApiErrorModel(
            message: "Forbidden. CSRF token may be invalid or missing.",
            statusCode: e.response?.statusCode,
          );
        case 404:
          return ApiErrorModel(
            message: "Resource not found.",
            statusCode: e.response?.statusCode,
          );
        case 500:
          return ApiErrorModel(
            message: "Internal server error. Please try again later.",
            statusCode: e.response?.statusCode,
          );
        default:
          return ApiErrorModel(
            message: "Error: ${e.response?.statusMessage}",
            statusCode: e.response?.statusCode,
          );
      }
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ApiErrorModel(
        message: "Connection timed out. Please check your internet.",
      );
    } else if (e.message != null && e.message!.contains('SocketException')) {
      return ApiErrorModel(
        message: "No internet connection. Please try again.",
      );
    } else {
      return ApiErrorModel(message: "Unexpected error occurred.");
    }
  }
}
