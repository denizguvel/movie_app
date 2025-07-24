import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_bloc.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_event.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_state.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_input_field.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_signup_row.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_social_buttons.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen:
            (previous, current) =>
                previous.isFailure != current.isFailure ||
                previous.isSuccess != current.isSuccess,
        listener: (context, state) {
          print(
            '[LOGIN] BlocListener state: isSuccess= ${state.isSuccess}, isFailure=${state.isFailure}',
          );
          if (state.isSuccess) {
            context.router.replace(const HomeRoute());
          } else if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Giriş başarısız!')),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        final bloc = context.read<LoginBloc>();
                        return Column(
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
                            LoginInputField(
                              icon: Icons.email_outlined,
                              hintTextKey: AppStrings.email,
                              obscureText: false,
                              onChanged: (val) => bloc.add(EmailChanged(val)),
                            ),
                            const SizedBox(height: 16),
                            LoginInputField(
                              icon: Icons.lock_outline,
                              hintTextKey: AppStrings.password,
                              obscureText: !state.isPasswordVisible,
                              isPassword: true,
                              onChanged:
                                  (val) => bloc.add(PasswordChanged(val)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                ),
                                onPressed:
                                    () => bloc.add(TogglePasswordVisibility()),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
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
                                onPressed:
                                    state.isSubmitting || state.isSuccess
                                        ? null
                                        : () => bloc.add(LoginSubmitted()),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child:
                                    state.isSubmitting
                                        ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : const Text(
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
                        );
                      },
                    ),
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
