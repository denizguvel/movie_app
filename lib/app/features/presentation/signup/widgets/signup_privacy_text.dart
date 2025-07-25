import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class SignupPrivacyText extends StatelessWidget {
  const SignupPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: AppStrings.privacyPolicyPrefix,
              style: const TextStyle(color: AppColors.white70),
            ),
            TextSpan(
              text: AppStrings.privacyPolicyBold,
              style: const TextStyle(
                color: AppColors.white,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: AppStrings.privacyPolicySuffix,
              style: const TextStyle(color: AppColors.white70),
            ),
          ],
        ),
      ),
    );
  }
} 