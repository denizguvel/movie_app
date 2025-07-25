import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class HomeErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const HomeErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${AppStrings.error}$message',
            style: const TextStyle(color: AppColors.white),
            textAlign: TextAlign.center,
          ),
          const CustomSizedbox(16),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(AppStrings.tryAgain),
          ),
        ],
      ),
    );
  }
} 