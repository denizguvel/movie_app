import 'package:dio/dio.dart';
import '../../models/auth/login_model.dart';

class AuthRemoteDatasource {
  final Dio dio;
  AuthRemoteDatasource({required this.dio});

  Future<Response> login({required String email, required String password}) async {
    final response = await dio.post(
      'https://caseapi.servicelabs.tech/user/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return response;
  }
}
