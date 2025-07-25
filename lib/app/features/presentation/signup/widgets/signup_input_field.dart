import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class SignupInputField extends StatelessWidget {
  final String iconAssetPath;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final String? suffixIconAssetPath;
  final VoidCallback? onSuffixIconTap;

  const SignupInputField({
    super.key,
    required this.iconAssetPath,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
    this.onChanged,
    this.suffixIconAssetPath,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: AppColors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            iconAssetPath,
            width: 15,
            height: 15,
            fit: BoxFit.contain,
          ),
        ),
        suffixIcon: suffixIconAssetPath != null
            ? GestureDetector(
                onTap: onSuffixIconTap,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset(
                    suffixIconAssetPath!,
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                    color: AppColors.white,
                  ),
                ),
              )
            : suffixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.white54),
        filled: true,
        fillColor: const Color(0xFF232323),
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
