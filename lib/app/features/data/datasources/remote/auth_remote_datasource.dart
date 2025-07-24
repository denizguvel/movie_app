import 'package:movie_app/app/common/config/config.dart';
import 'package:movie_app/app/features/data/models/auth/signup_model.dart';
import 'package:movie_app/core/dio_manager/api_response_model.dart';
import 'package:movie_app/core/dio_manager/dio_manager.dart';

abstract class AuthRemoteDatasource {
  Future<ApiResponseModel<String>> signup({required SignupModel signupModel});
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
}
