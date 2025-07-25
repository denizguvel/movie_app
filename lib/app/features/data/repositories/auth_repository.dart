import 'package:movie_app/app/features/data/datasources/local/auth_local_datasource.dart';
import 'package:movie_app/app/features/data/datasources/remote/auth_remote_datasource.dart';
import 'package:movie_app/app/features/data/models/auth/auth_user_model.dart';
import 'package:movie_app/app/features/data/models/auth/login_model.dart';
import 'package:movie_app/app/features/data/models/auth/signup_model.dart';
import 'package:movie_app/core/logger/app_logger.dart';
import 'package:movie_app/core/result/result.dart';
import 'dart:io';
import 'package:movie_app/app/features/data/models/auth/upload_image_response.dart';

abstract class AuthRepository {
  Future<DataResult<String>> signup({required SignupModel signupModel});
  Future<DataResult<String>> login({required LoginModel loginModel});
  Future<DataResult<AuthUserModel>> getProfile();
  Future<DataResult<UploadImageResponse>> uploadProfileImage({required File imageFile});
  Future<void> clearAllData();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;
  final AuthLocalDatasource _localDatasource;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDatasource,
    required AuthLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<DataResult<String>> signup({required SignupModel signupModel}) async {
    var apiResponseModel = await _remoteDatasource.signup(
      signupModel: signupModel,
    );
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
        "$runtimeType signup() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}",
      );
      return ErrorDataResult(
        message:
            "${apiResponseModel.error?.message ?? ""} ${apiResponseModel.error?.statusCode ?? ""}",
      );
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType register() Null Data");
      return ErrorDataResult(
        message:
            "${apiResponseModel.error?.message ?? ""} ${apiResponseModel.error?.statusCode ?? ""}",
      );
    }
    
    // Önce eski verileri temizle, sonra yeni token'ı kaydet
    await _localDatasource.clearAllData();
    await _localDatasource.saveToken(apiResponseModel.data!);
    await _localDatasource.login();
    AppLogger.instance.log("$runtimeType register() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!);
  }

  @override
  Future<DataResult<String>> login({required LoginModel loginModel}) async {
    var apiResponseModel = await _remoteDatasource.login(
      loginModel: loginModel,
    );
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
        "$runtimeType login() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}",
      );
      return ErrorDataResult(
        message:
            "${apiResponseModel.error?.message ?? ""} ${apiResponseModel.error?.statusCode ?? ""}",
      );
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType login() Null Data");
      return ErrorDataResult(
        message:
            "${apiResponseModel.error?.message ?? ""} ${apiResponseModel.error?.statusCode ?? ""}",
      );
    }
    
    // Önce eski verileri temizle, sonra yeni token'ı kaydet
    await _localDatasource.clearAllData();
    await _localDatasource.saveToken(apiResponseModel.data!);
    await _localDatasource.login();
    AppLogger.instance.log("$runtimeType login() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!);
  }

  @override
  Future<DataResult<AuthUserModel>> getProfile() async {
    var apiResponseModel = await _remoteDatasource.getProfile();
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
        "$runtimeType getProfile() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}",
      );
      return ErrorDataResult(
        message:
            "${apiResponseModel.error?.message ?? ""} ${apiResponseModel.error?.statusCode ?? ""}",
      );
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType getProfile() Null Data");
      return ErrorDataResult(
        message:
            "${apiResponseModel.error?.message ?? ""} ${apiResponseModel.error?.statusCode ?? ""}",
      );
    }
    try {
      await _localDatasource.saveUser(
        apiResponseModel.data ?? const AuthUserModel(),
      );
    } catch (e) {
      AppLogger.instance.error("$runtimeType getProfile() ${e.toString()}");
      return ErrorDataResult(message: e.toString());
    }
    AppLogger.instance.log("$runtimeType getProfile() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!);
  }

  @override
  Future<DataResult<UploadImageResponse>> uploadProfileImage({required File imageFile}) async {
    var apiResponseModel = await _remoteDatasource.uploadProfileImage(imageFile: imageFile);
    if (!apiResponseModel.isSuccess) {
      return ErrorDataResult(message: apiResponseModel.error?.message ?? 'Upload failed');
    }
    if (apiResponseModel.data == null) {
      return ErrorDataResult(message: 'No data returned');
    }
    return SuccessDataResult(data: apiResponseModel.data!);
  }

  @override
  Future<void> clearAllData() async {
    await _localDatasource.clearAllData();
  }
}
