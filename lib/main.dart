import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_theme_data.dart';
import 'package:movie_app/app/common/functions/app_functions.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar_bloc.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_bloc.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_bloc.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_bloc.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_event.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_bloc.dart';
import 'package:movie_app/app/features/presentation/splash/bloc/splash_bloc.dart';
import 'package:movie_app/core/keys/app_keys.dart';

Future<void> main() async {
  await AppFunctions.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final appRouter = getIt.get<AppRouter>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<AppBottomNavbarBloc>()),
        BlocProvider(
          create: (_) {
            final bloc = getIt<ProfileBloc>();
            bloc.add(FetchProfileRequested());
            return bloc;
          },
        ),
        BlocProvider(create: (_) => getIt<HomeBloc>()),
        BlocProvider(create: (_) => getIt<SignupBloc>()),
        BlocProvider(create: (_) => getIt<ExploreBloc>()),
        BlocProvider(create: (_) => getIt<SplashBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
        title: 'Movie App',
        routerConfig: appRouter.config(),
        theme: AppThemeData.themeData,
      ),
    );
  }
}
