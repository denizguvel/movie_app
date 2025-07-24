import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_input_field.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_signup_row.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_social_buttons.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.hello,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.loginScreenWelcome,
                      style: const TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Email
                    const LoginInputField(
                      icon: Icons.email_outlined,
                      hintTextKey: AppStrings.email,
                      obscureText: false,
                    ),
                    const CustomSizedbox(16),
                    const LoginInputField(
                      icon: Icons.lock_outline,
                      hintTextKey: AppStrings.password,
                      obscureText: true,
                      isPassword: true,
                    ),
                    const CustomSizedbox(8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          AppStrings.forgotPassword,
                          style: const TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          AppStrings.login,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const LoginSocialButtons(),
                    const SizedBox(height: 24),
                    const LoginSignupRow(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
