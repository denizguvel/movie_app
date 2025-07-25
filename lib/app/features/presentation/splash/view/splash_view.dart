import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/features/presentation/splash/bloc/splash_bloc.dart';
import 'package:movie_app/app/features/presentation/splash/bloc/splash_event.dart';
import 'package:movie_app/app/features/presentation/splash/bloc/splash_state.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final SplashBloc _splashBloc;

  @override
  void initState() {
    super.initState();
    _splashBloc = getIt<SplashBloc>();
    _splashBloc.add(const LoadInitialData());
  }

  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _splashBloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToLogin) {
            context.router.push(const LoginRoute());
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: Lottie.asset('assets/lottie/Movie.json'),
                ),
                const CustomSizedbox(32),
                Text(
                  AppStrings.shartflix,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: AppColors.red.withOpacity(0.7),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
                const CustomSizedbox(24),
                BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading) {
                      return const CircularProgressIndicator(
                        color: AppColors.red,
                        strokeWidth: 3,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
