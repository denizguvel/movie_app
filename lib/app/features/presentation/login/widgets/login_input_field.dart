import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class LoginInputField extends StatelessWidget {
  final String iconAssetPath;
  final String hintTextKey;
  final bool obscureText;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final Color? color;
  final String? suffixIconAssetPath;
  final VoidCallback? onSuffixIconTap;

  const LoginInputField({
    super.key,
    required this.iconAssetPath,
    required this.hintTextKey,
    required this.obscureText,
    this.isPassword = false,
    this.onChanged,
    this.suffixIcon,
    this.color,
    this.suffixIconAssetPath,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            iconAssetPath,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
        suffixIcon:
            suffixIconAssetPath != null
                ? (isPassword
                    ? GestureDetector(
                        onTap: onSuffixIconTap,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Image.asset(
                            suffixIconAssetPath!,
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Image.asset(
                          suffixIconAssetPath!,
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: AppColors.white,
                        ),
                      ))
                : (suffixIcon ??
                    (isPassword
                        ? const Icon(
                          Icons.visibility_off,
                          color: AppColors.white,
                          size: 20,
                        )
                        : null)),
        hintText: hintTextKey,
        hintStyle: const TextStyle(color: Colors.white60),
        filled: true,
        fillColor: const Color(0xFF232323),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
