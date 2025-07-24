import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final IconData icon;
  final String hintTextKey;
  final bool obscureText;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  const LoginInputField({
    super.key,
    required this.icon,
    required this.hintTextKey,
    required this.obscureText,
    this.isPassword = false,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: suffixIcon ?? (isPassword
            ? const Icon(Icons.visibility_off, color: Colors.white54)
            : null),
        hintText: hintTextKey,
        hintStyle: const TextStyle(color: Colors.white60),
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