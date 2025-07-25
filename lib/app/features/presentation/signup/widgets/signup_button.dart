import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class SignupButton extends StatelessWidget {
  final bool isSubmitting;
  final bool isSuccess;
  final VoidCallback onPressed;

  const SignupButton({
    super.key,
    required this.isSubmitting,
    required this.isSuccess,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isSubmitting || isSuccess ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: isSubmitting
            ? const CircularProgressIndicator(
                color: AppColors.white,
              )
            : Text(
                AppStrings.signupButton,
                style: const TextStyle(fontSize: 16, color: AppColors.white),
              ),
      ),
    );
  }
} 