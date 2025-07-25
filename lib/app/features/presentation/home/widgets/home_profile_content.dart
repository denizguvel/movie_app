import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class HomeProfileContent extends StatelessWidget {
  const HomeProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.profilePage,
        style: const TextStyle(fontSize: 24, color: AppColors.white),
      ),
    );
  }
} 