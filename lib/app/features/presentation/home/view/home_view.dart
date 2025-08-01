import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar_bloc.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/features/presentation/home/widgets/home_app_bar.dart';
import 'package:movie_app/app/features/presentation/home/widgets/home_view_body.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBottomNavbarBloc, int>(
      bloc: getIt<AppBottomNavbarBloc>(),
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: const HomeAppBar(),
          body: HomeViewBody(currentIndex: currentIndex),
          backgroundColor: AppColors.black,
          bottomNavigationBar: AppBottomNavbar(
            selectedIndex: currentIndex,
            onTap: (index, ctx) {
              getIt<AppBottomNavbarBloc>().add(AppBottomNavbarEvent.values[index]);
              if (index == 0) {
                ctx.router.replace(const HomeRoute());
              } else if (index == 1) {
                ctx.router.replace(const ProfileRoute());
              }
            },
          ),
        );
      },
    );
  }
}
