import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';

class LoginSignupRow extends StatelessWidget {
  const LoginSignupRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.signupMessage,
          style: const TextStyle(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {
            context.router.push(const SignupRoute());
          },
          child: Text(
            AppStrings.signupButtonExclamation,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
} 