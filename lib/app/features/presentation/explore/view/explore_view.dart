import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar_bloc.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/features/presentation/explore/widgets/explore_background.dart';
import 'package:movie_app/app/features/presentation/explore/widgets/explore_movie_info.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_bloc.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_event.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_state.dart';

@RoutePage()
class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExploreBloc>()..add(const LoadFeaturedContent()),
      child: BlocBuilder<AppBottomNavbarBloc, int>(
        bloc: getIt<AppBottomNavbarBloc>(),
        builder: (context, currentIndex) {
          return Scaffold(
            backgroundColor: AppColors.black,
            body: Stack(
              children: [
                const ExploreBackground(),
                Column(
                  children: [
                    const Spacer(),
                    BlocBuilder<ExploreBloc, ExploreState>(
                      builder: (context, state) {
                        if (state is ExploreLoading) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: AppColors.red,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  AppStrings.exploreLoading,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (state is ExploreLoaded) {
                          return ExploreMovieInfo(
                            movieTitle: state.featuredMovieTitle,
                            movieDescription: state.featuredMovieDescription,
                            movieId: state.featuredMovieId,
                            isLiked: state.isLiked,
                          );
                        } else if (state is ExploreError) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.message,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<ExploreBloc>().add(const RefreshExploreContent());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.exploreRefresh,
                                    style: const TextStyle(color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    AppBottomNavbar(
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
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
