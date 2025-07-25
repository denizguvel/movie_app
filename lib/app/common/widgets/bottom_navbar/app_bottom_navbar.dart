import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';

class AppBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int, BuildContext) onTap;

  const AppBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavButton(
            iconAssetPath: 'assets/icons/Home.png',
            label: AppStrings.bottomNavHome,
            selected: selectedIndex == 0,
            onTap: () => onTap(0, context),
          ),
          _NavButton(
            iconAssetPath: 'assets/icons/profile.png',
            label: AppStrings.bottomNavProfile,
            selected: selectedIndex == 1,
            onTap: () => onTap(1, context),
            isProfile: true,
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String iconAssetPath;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isProfile;

  const _NavButton({
    required this.iconAssetPath,
    required this.label,
    required this.selected,
    required this.onTap,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.white12 : AppColors.transparent,
          border: Border.all(
            color: selected ? AppColors.white : AppColors.white24,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isProfile)
              SizedBox(
                width: 24,
                height: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/person1.png',
                      width: 12,
                      height: 12,
                      fit: BoxFit.contain,
                      color: AppColors.white,
                    ),
                    Image.asset(
                      'assets/icons/person2.png',
                      width: 12,
                      height: 12,
                      fit: BoxFit.contain,
                      color: AppColors.white,
                    ),
                  ],
                ),
              )
            else
              Image.asset(
                iconAssetPath,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
                color: AppColors.white,
              ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
