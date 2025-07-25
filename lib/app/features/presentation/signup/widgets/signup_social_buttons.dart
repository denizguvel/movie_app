import 'package:flutter/material.dart';

class SignupSocialButtons extends StatelessWidget {
  const SignupSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSocialButton('assets/icons/google.png', () {}),
        const SizedBox(width: 16),
        buildSocialButton('assets/icons/apple.png', () {}),
        const SizedBox(width: 16),
        buildSocialButton('assets/icons/facebook.png', () {}),
      ],
    );
  }

  Widget buildSocialButton(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF232323),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
