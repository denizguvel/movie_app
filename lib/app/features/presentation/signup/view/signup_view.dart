import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_header.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_form.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_button.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_login_row.dart';
import 'package:movie_app/app/features/presentation/signup/widgets/signup_social_buttons.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_bloc.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_event.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_state.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';

@RoutePage()
class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen:
          (previous, current) =>
              previous.isFailure != current.isFailure ||
              previous.isSuccess != current.isSuccess,
      listener: (context, state) {
        if (state.isSuccess) {
          context.router.replace(const ExploreRoute());
        } else if (state.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? AppStrings.registrationFailed,
              ),
            ),
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    final bloc = context.read<SignupBloc>();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SignupHeader(),
                        const CustomSizedbox(40),
                        SignupForm(
                          bloc: bloc,
                          isSubmitting: state.isSubmitting,
                          isSuccess: state.isSuccess,
                          state: state,
                        ),
                        const CustomSizedbox(38),
                        SignupButton(
                          isSubmitting: state.isSubmitting,
                          isSuccess: state.isSuccess,
                          onPressed: () => bloc.add(SignupSubmitted()),
                        ),
                        const CustomSizedbox(37),
                        const SignupSocialButtons(),
                        const CustomSizedbox(33),
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
    );
  }
}
