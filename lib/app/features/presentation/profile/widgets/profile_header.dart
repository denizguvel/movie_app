import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final String? photoUrl;
  final String displayName;
  final String displayId;
  final bool isUploading;
  final VoidCallback onAddPhoto;

  const ProfileHeader({
    super.key,
    required this.photoUrl,
    required this.displayName,
    required this.displayId,
    required this.isUploading,
    required this.onAddPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: AppColors.grey800,
              backgroundImage: (photoUrl != null && photoUrl!.isNotEmpty)
                  ? NetworkImage(photoUrl!)
                  : null,
            ),
            if (isUploading)
              const Positioned.fill(
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.red),
                ),
              ),
          ],
        ),
        const CustomSizedbox(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CustomSizedbox(4),
              Text(
                'ID: $displayId',
                style: const TextStyle(
                  color: AppColors.white54,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: onAddPhoto,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
          child: Text(
            AppStrings.addPhoto,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
          ),
        ),
      ],
    );
  }
} 