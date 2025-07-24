import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar_bloc.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBottomNavbarBloc, int>(
      bloc: getIt<AppBottomNavbarBloc>(),
      builder: (context, currentIndex) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/logo/SinFlixLogo.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          body: Center(
            child: Text(
              currentIndex == 0 ? 'Hoşgeldin!' : 'Profil Sayfası',
              style: const TextStyle(fontSize: 24),
            ),
          ),
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
