import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_event.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_state.dart';
import 'package:movie_app/app/features/presentation/home/widgets/home_movie_grid.dart';
import 'package:movie_app/app/features/presentation/home/widgets/home_error_widget.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<HomeBloc>().add(const LoadMovies());
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HomeError) {
          return HomeErrorWidget(
            message: state.message,
            onRetry: () {
              context.read<HomeBloc>().add(const LoadMovies());
            },
          );
        }

        if (state is HomeLoaded || state is HomeLoadingMore) {
          final movies = state is HomeLoaded 
              ? (state as HomeLoaded).movies 
              : (state as HomeLoadingMore).movies;
          final hasReachedMax = state is HomeLoaded 
              ? (state as HomeLoaded).hasReachedMax 
              : false;
          final favoriteIds = state is HomeLoaded ? (state as HomeLoaded).favoriteIds : <String>{};

          return HomeMovieGrid(
            movies: movies,
            favoriteIds: favoriteIds,
            hasReachedMax: hasReachedMax,
            onRefresh: () {
              context.read<HomeBloc>().add(const RefreshMovies());
            },
            onLoadMore: () {
              context.read<HomeBloc>().add(const LoadMoreMovies());
            },
            onToggleFavorite: (movieId) {
              context.read<HomeBloc>().add(ToggleFavorite(movieId));
            },
          );
        }

        return Center(
          child: Text(
            AppStrings.unknownState,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
} 