import 'dart:developer';
import 'dart:io';

import 'package:movie_app/app/common/config/config.dart';
import 'package:movie_app/app/features/data/models/auth/auth_user_model.dart';
import 'package:movie_app/app/features/data/models/auth/login_model.dart';
import 'package:movie_app/app/features/data/models/auth/signup_model.dart';
import 'package:movie_app/app/features/data/models/auth/upload_image_response.dart';
import 'package:movie_app/core/dio_manager/api_response_model.dart';
import 'package:movie_app/core/dio_manager/dio_manager.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDatasource {
  Future<ApiResponseModel<String>> signup({required SignupModel signupModel});
  Future<ApiResponseModel<String>> login({required LoginModel loginModel});
  Future<ApiResponseModel<AuthUserModel>> getProfile();
  Future<ApiResponseModel<UploadImageResponse>> uploadProfileImage({
    required File imageFile,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioApiManager _apiManager = DioApiManager(baseUrl: Config.apiBaseUrl);

  @override
  Future<ApiResponseModel<String>> signup({
    required SignupModel signupModel,
  }) async {
    var apiResponseModel = await _apiManager.post(
      '/user/register',
      data: signupModel.toMap(),
      converter: (data) {
        final token = data['data']?['token'];
        if (token == null) {
          throw Exception("API response does not contain 'token': $data");
        }
        return token as String;
      },
    );
    return apiResponseModel;
  }

  @override
  Future<ApiResponseModel<String>> login({
    required LoginModel loginModel,
  }) async {
    var apiResponseModel = await _apiManager.post(
      "/user/login/",
      data: {"password": loginModel.password, "email": loginModel.email},
      converter: (data) {
        final token = data['data']?['token'];
        if (token == null) {
          throw Exception("API response does not contain 'token': $data");
        }
        return token as String;
      },
    );
    return apiResponseModel;
  }

  @override
  Future<ApiResponseModel<AuthUserModel>> getProfile() async {
    var apiResponseModel = await _apiManager.get(
      "/user/profile/",
      converter: (data) {
        log(data.toString());
        return AuthUserModel.fromMap(data['data']);
      },
    );
    return apiResponseModel;
  }

  @override
  Future<ApiResponseModel<UploadImageResponse>> uploadProfileImage({
    required File imageFile,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: 'profile.jpg',
      ),
    });
    var apiResponseModel = await _apiManager.post(
      '/user/upload_photo',
      data: formData,
      converter: (data) {
        return UploadImageResponse.fromMap(data);
      },
    );
    return apiResponseModel;
  }
}
