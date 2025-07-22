import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

final class AppThemeData {
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    //bottomNavigationBarTheme: _bottomNavigationBarTheme,
    appBarTheme: _appBarTheme,
    textTheme: const TextTheme(
      displayLarge: TextStyle(),
      displayMedium: TextStyle(),
      displaySmall: TextStyle(),
      headlineLarge: TextStyle(),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(),
      titleLarge: TextStyle(),
      titleMedium: TextStyle(),
      titleSmall: TextStyle(),
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
      labelLarge: TextStyle(),
      labelMedium: TextStyle(),
      labelSmall: TextStyle(),
    ).apply(
      fontFamily: 'Avenir',
      displayColor: AppColors.primaryWhite,
      bodyColor: AppColors.primaryWhite,
    ),
  );

  // static const BottomNavigationBarThemeData _bottomNavigationBarTheme =
  //     BottomNavigationBarThemeData(
  //   backgroundColor: AppColors.borderGreen,
  //   elevation: 0,
  //   type: BottomNavigationBarType.fixed,
  //   selectedItemColor: AppColors.borderGreen,
  //   unselectedItemColor: AppColors.borderGreen,
  //   unselectedLabelStyle: TextStyle(
  //     color: AppColors.borderGreen,
  //     fontSize: 12,
  //     fontWeight: FontWeight.w600,
  //   ),
  //   selectedLabelStyle: TextStyle(
  //     color: AppColors.borderGreen,
  //     fontSize: 12,
  //     fontWeight: FontWeight.w600,
  //   ),
  // );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColors.primaryWhite,
    centerTitle: false,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.primaryWhite,
    ),
    scrolledUnderElevation: 0,
    actionsPadding: EdgeInsets.only(right: 20),
  );
}
