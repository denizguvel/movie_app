import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/core/helper/device/device_info_helper.dart';
import 'package:movie_app/core/storage/hive/hive.dart';

final class AppFunctions {
  AppFunctions._();
  static final AppFunctions instance = AppFunctions._();
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await hiveInit();
    await DeviceInfoHelper.instance.init();
    ServiceLocator().setup();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
