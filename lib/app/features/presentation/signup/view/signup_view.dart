import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_input_field.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_login_row.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_privacy_text.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_social_buttons.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_bloc.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_event.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_state.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';

@RoutePage()
class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    print('[SIGNUP] SignupView build');
    return BlocProvider(
      create: (_) {
        print('[SIGNUP] BlocProvider create');
        return getIt<SignupBloc>();
      },
      child: BlocListener<SignupBloc, SignupState>(
        listenWhen:
            (previous, current) =>
                previous.isFailure != current.isFailure ||
                previous.isSuccess != current.isSuccess,
        listener: (context, state) {
          print(
            '[SIGNUP] BlocListener state: isSuccess=${state.isSuccess}, isFailure=${state.isFailure}',
          );
          if (state.isSuccess) {
            context.router.replace(const HomeRoute());
          } else if (state.isFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Kayıt başarısız!')),
            );
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: BlocBuilder<SignupBloc, SignupState>(
                    builder: (context, state) {
                      final bloc = context.read<SignupBloc>();
                      print('[SIGNUP] BlocBuilder state: $state');
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.signupWelcome,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppStrings.signupScreenWelcome,
                            style: const TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SignupInputField(
                            icon: Icons.person_outline,
                            hintText: AppStrings.nameSurname,
                            obscureText: false,
                            onChanged:
                                (val) => bloc.add(SignupNameChanged(val)),
                          ),
                          const SizedBox(height: 16),
                          SignupInputField(
                            icon: Icons.email_outlined,
                            hintText: AppStrings.email,
                            obscureText: false,
                            onChanged:
                                (val) => bloc.add(SignupEmailChanged(val)),
                          ),
                          const SizedBox(height: 16),
                          SignupInputField(
                            icon: Icons.lock_outline,
                            hintText: AppStrings.password,
                            obscureText: true,
                            onChanged:
                                (val) => bloc.add(SignupPasswordChanged(val)),
                            suffixIcon: const Icon(
                              Icons.visibility_off,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SignupInputField(
                            icon: Icons.lock_outline,
                            hintText: AppStrings.passwordAgain,
                            obscureText: true,
                            // Şifre tekrar için ayrı bir event eklenebilir, şimdilik dummy
                            onChanged: (val) {},
                            suffixIcon: const Icon(
                              Icons.visibility_off,
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const SignupPrivacyText(),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  state.isSubmitting || state.isSuccess
                                      ? null
                                      : () => bloc.add(SignupSubmitted()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child:
                                  state.isSubmitting
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : const Text(
                                        AppStrings.signupButton,
                                        style: TextStyle(fontSize: 16),
                                      ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const SignupSocialButtons(),
                          const SizedBox(height: 24),
                          const SignupLoginRow(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
