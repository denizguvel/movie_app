import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';

class ProfileLimitedOfferButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ProfileLimitedOfferButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          'assets/icons/diamond.png',
          color: Colors.white,
          width: 18,
        ),
        label: Text(
          AppStrings.limitedOffer,
          style: const TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryRed,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
