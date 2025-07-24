import 'package:movie_app/app/features/data/datasources/local/auth_local_datasource.dart';
import 'package:movie_app/app/features/data/datasources/remote/auth_remote_datasource.dart';
import 'package:movie_app/app/features/data/models/auth/login_model.dart';
import 'package:movie_app/app/features/data/models/auth/signup_model.dart';
import 'package:movie_app/core/logger/app_logger.dart';
import 'package:movie_app/core/result/result.dart';


abstract class AuthRepository {
  Future<DataResult<String>> signup({required SignupModel signupModel});
  Future<DataResult<String>> login({required LoginModel loginModel});
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
    await _localDatasource.saveToken(apiResponseModel.data!);
    await _localDatasource.login();
    AppLogger.instance.log("$runtimeType login() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!);
  }
}
