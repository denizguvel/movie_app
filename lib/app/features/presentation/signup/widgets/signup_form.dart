import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_input_field.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_privacy_text.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_bloc.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_event.dart';

class SignupForm extends StatelessWidget {
  final SignupBloc bloc;
  final bool isSubmitting;
  final bool isSuccess;

  const SignupForm({
    super.key,
    required this.bloc,
    required this.isSubmitting,
    required this.isSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignupInputField(
          icon: Icons.person_outline,
          hintText: AppStrings.nameSurname,
          obscureText: false,
          onChanged: (val) => bloc.add(SignupNameChanged(val)),
        ),
        const CustomSizedbox(16),
        SignupInputField(
          icon: Icons.email_outlined,
          hintText: AppStrings.email,
          obscureText: false,
          onChanged: (val) => bloc.add(SignupEmailChanged(val)),
        ),
        const CustomSizedbox(16),
        SignupInputField(
          icon: Icons.lock_outline,
          hintText: AppStrings.password,
          obscureText: true,
          onChanged: (val) => bloc.add(SignupPasswordChanged(val)),
          suffixIcon: const Icon(
            Icons.visibility_off,
            color: AppColors.white54,
          ),
        ),
        const CustomSizedbox(16),
        SignupInputField(
          icon: Icons.lock_outline,
          hintText: AppStrings.passwordAgain,
          obscureText: true,
          onChanged: (val) {},
          suffixIcon: const Icon(
            Icons.visibility_off,
            color: AppColors.white54,
          ),
        ),
        const CustomSizedbox(12),
        const SignupPrivacyText(),
      ],
    );
  }
} 