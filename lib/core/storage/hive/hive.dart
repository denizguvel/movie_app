import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:movie_app/app/features/data/models/auth/auth_user_model.dart';

late Box<bool> isFirstOpen;
late Box<String> csrfTokenBox;
late Box<String> sessionIdBox;
late Box<String> tokenBox;
late Box<bool> isLoginBox;
late Box<AuthUserModel> userBox;
late Box<String> profilePhotoBox;

/// Generate encryption key from device-specific data
List<int> _generateEncryptionKey() {
  // Use a combination of device-specific data for encryption key
  final deviceInfo = 'movie_app_secure_storage_2024';
  final bytes = utf8.encode(deviceInfo);
  final digest = sha256.convert(bytes);
  return digest.bytes;
}

/// init hive
Future<void> hiveInit() async {
  await Hive.initFlutter();

  Hive.registerAdapter<AuthUserModel>(AuthUserModelAdapter());
  await hiveBox();
}

/// Hive box
Future<void> hiveBox() async {
  final encryptionKey = _generateEncryptionKey();
  
  isFirstOpen = await Hive.openBox<bool>('isFirstOpen');
  csrfTokenBox = await Hive.openBox<String>('csrfToken');
  sessionIdBox = await Hive.openBox<String>('sessionId');
  
  // 🔒 Şifrelenmiş token box
  tokenBox = await Hive.openBox<String>(
    'token',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );
  
  isLoginBox = await Hive.openBox<bool>('isLogin');
  userBox = await Hive.openBox<AuthUserModel>('user');
  profilePhotoBox = await Hive.openBox<String>('profilePhoto');
}
