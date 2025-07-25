import 'package:flutter/material.dart';
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
        icon: const Icon(
          Icons.local_offer,
          color: Colors.white,
          size: 18,
        ),
        label: Text(AppStrings.limitedOffer),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
} 