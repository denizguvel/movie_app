import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_bloc.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_event.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_state.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_input_field.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_signup_row.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_social_buttons.dart';

class LoginViewBody extends StatelessWidget {
  final LoginBloc bloc;
  final LoginState state;
  const LoginViewBody({super.key, required this.bloc, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.hello,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const CustomSizedbox(8),
        Text(
          AppStrings.loginScreenWelcome,
          style: const TextStyle(color: AppColors.white),
          textAlign: TextAlign.center,
        ),
        const CustomSizedbox(40),
        LoginInputField(
          iconAssetPath: 'assets/icons/Message.png',
          hintTextKey: AppStrings.email,
          obscureText: false,
          onChanged: (val) => bloc.add(EmailChanged(val)),
        ),
        const CustomSizedbox(16),
        LoginInputField(
          iconAssetPath: 'assets/icons/Unlock.png',
          hintTextKey: AppStrings.password,
          obscureText: !state.isPasswordVisible,
          isPassword: true,
          onChanged: (val) => bloc.add(PasswordChanged(val)),
          suffixIconAssetPath:
              state.isPasswordVisible
                  ? 'assets/icons/Hide.png'
                  : 'assets/icons/Hide.png',
          onSuffixIconTap: () => bloc.add(TogglePasswordVisibility()),
        ),
        const CustomSizedbox(20),
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
                color: AppColors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const CustomSizedbox(24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                state.isSubmitting || state.isSuccess
                    ? null
                    : () => bloc.add(LoginSubmitted()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child:
                state.isSubmitting
                    ? const CircularProgressIndicator(color: AppColors.white)
                    : Text(
                      AppStrings.login,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
          ),
        ),
        const CustomSizedbox(37),
        const LoginSocialButtons(),
        const CustomSizedbox(33),
        const LoginSignupRow(),
      ],
    );
  }
}
