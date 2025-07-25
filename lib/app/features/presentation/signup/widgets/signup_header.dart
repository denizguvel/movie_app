import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.signupWelcome,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const CustomSizedbox(8),
        Text(
          AppStrings.signupScreenWelcome,
          style: const TextStyle(color: AppColors.white70),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
} 