import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';

class SignupLoginRow extends StatelessWidget {
  const SignupLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount,
          style: const TextStyle(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {
            context.router.pop();
          },
          child: Text(
            AppStrings.loginButtonExclamation,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
} 