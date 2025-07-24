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
      await tokenBox.put('token', token);
    } catch (e) {
      AppLogger.instance.error("$runtimeType saveToken() ${e.toString()}");
    }
  }

  @override
  String getToken() {
    try {
      return tokenBox.get('token', defaultValue: '') ?? '';
    } catch (e) {
      return '';
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await tokenBox.delete('token');
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
}
