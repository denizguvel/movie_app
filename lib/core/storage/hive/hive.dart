import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'package:movie_app/app/features/data/models/auth/auth_user_model.dart';

late Box<bool> isFirstOpen;
late Box<String> csrfTokenBox;
late Box<String> sessionIdBox;
late Box<String> tokenBox;
late Box<bool> isLoginBox;
late Box<AuthUserModel> userBox;
late Box<String> profilePhotoBox;

/// init hive
Future<void> hiveInit() async {
  await Hive.initFlutter();

  Hive.registerAdapter<AuthUserModel>(AuthUserModelAdapter());
  await hiveBox();
}

/// Hive box
Future<void> hiveBox() async {
  isFirstOpen = await Hive.openBox<bool>('isFirstOpen');
  csrfTokenBox = await Hive.openBox<String>('csrfToken');
  sessionIdBox = await Hive.openBox<String>('sessionId');
  tokenBox = await Hive.openBox<String>('token');
  isLoginBox = await Hive.openBox<bool>('isLogin');
  userBox = await Hive.openBox<AuthUserModel>('user');
  profilePhotoBox = await Hive.openBox<String>('profilePhoto');
}
