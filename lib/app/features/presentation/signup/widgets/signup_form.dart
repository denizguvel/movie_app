import 'package:flutter/material.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_input_field.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_privacy_text.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_bloc.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_event.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_state.dart';

class SignupForm extends StatelessWidget {
  final SignupBloc bloc;
  final bool isSubmitting;
  final bool isSuccess;
  final SignupState state;

  const SignupForm({
    super.key,
    required this.bloc,
    required this.isSubmitting,
    required this.isSuccess,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignupInputField(
          iconAssetPath: 'assets/icons/AddUser.png',
          hintText: AppStrings.nameSurname,
          obscureText: false,
          onChanged: (val) => bloc.add(SignupNameChanged(val)),
        ),
        const CustomSizedbox(16),
        SignupInputField(
          iconAssetPath: 'assets/icons/Message.png',
          hintText: AppStrings.email,
          obscureText: false,
          onChanged: (val) => bloc.add(SignupEmailChanged(val)),
        ),
        const CustomSizedbox(16),
        SignupInputField(
          iconAssetPath: 'assets/icons/Unlock.png',
          hintText: AppStrings.password,
          obscureText: !state.isPasswordVisible,
          onChanged: (val) => bloc.add(SignupPasswordChanged(val)),
          suffixIconAssetPath: 'assets/icons/Hide.png',
          onSuffixIconTap: () => bloc.add(TogglePasswordVisibility()),
        ),
        const CustomSizedbox(16),
        SignupInputField(
          iconAssetPath: 'assets/icons/Unlock.png',
          hintText: AppStrings.passwordAgain,
          obscureText: !state.isPasswordAgainVisible,
          onChanged: (val) {},
          suffixIconAssetPath: 'assets/icons/Hide.png',
          onSuffixIconTap: () => bloc.add(TogglePasswordAgainVisibility()),
        ),
        const CustomSizedbox(17),
        const SignupPrivacyText(),
      ],
    );
  }
}
