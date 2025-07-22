import '../datasources/remote/auth_remote_datasource.dart';
import '../models/auth/login_model.dart';

class AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepository({required this.remoteDatasource});

  Future<bool> login({required String email, required String password}) async {
    final response = await remoteDatasource.login(email: email, password: password);
    // Burada response'dan başarılı olup olmadığını kontrol edebilirsin
    if (response.statusCode == 200) {
      // Gerekirse response'dan token veya user bilgisi dönebilirsin
      return true;
    }
    return false;
  }
}
