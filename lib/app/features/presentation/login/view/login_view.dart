import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_bloc.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_state.dart';
import 'package:movie_app/app/features/presentation/login/widgets/login_view_body.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen:
          (previous, current) =>
              previous.isFailure != current.isFailure ||
              previous.isSuccess != current.isSuccess,
      listener: (context, state) {
        if (state.isSuccess) {
          context.router.replace(const HomeRoute());
        } else if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? AppStrings.loginFailed)),
          );
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      final bloc = context.read<LoginBloc>();
                      return LoginViewBody(bloc: bloc, state: state);
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
