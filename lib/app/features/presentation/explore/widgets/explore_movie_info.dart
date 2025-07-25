import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';
import 'package:movie_app/app/common/widgets/sizedbox/custom_sizedbox.dart';
import 'package:movie_app/app/features/presentation/home/view/home_view.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_bloc.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_event.dart';

class ExploreMovieInfo extends StatelessWidget {
  final String movieTitle;
  final String movieDescription;
  final String movieId;
  final bool isLiked;

  const ExploreMovieInfo({
    super.key,
    required this.movieTitle,
    required this.movieDescription,
    required this.movieId,
    required this.isLiked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'N',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const CustomSizedbox(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieTitle,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: movieDescription,
                        style: const TextStyle(
                          color: AppColors.white70,
                          fontSize: 16,
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            context.read<ExploreBloc>().add(const NavigateToHomeWithAnimation());
                            context.router.push(
                              const HomeRoute(),
                              onFailure: (failure) {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation, secondaryAnimation) => const HomeView(),
                                    transitionsBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOutCubic;

                                      var tween = Tween(
                                        begin: begin,
                                        end: end,
                                      ).chain(CurveTween(curve: curve));

                                      var offsetAnimation = animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: FadeTransition(opacity: animation, child: child),
                                      );
                                    },
                                    transitionDuration: const Duration(milliseconds: 800),
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            AppStrings.readMore,
                            style: const TextStyle(
                              color: AppColors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const CustomSizedbox(16),
          GestureDetector(
            onTap: () {
              context.read<ExploreBloc>().add(
                ToggleMovieLike(movieId: movieId, currentIsLiked: isLiked),
              );
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? AppColors.red : AppColors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
