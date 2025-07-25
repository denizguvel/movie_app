import 'package:flutter/material.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';
import 'package:movie_app/app/features/presentation/home/widgets/movie_card.dart';
import 'package:movie_app/app/common/constants/app_colors.dart';

class HomeMovieGrid extends StatelessWidget {
  final List<MovieModel> movies;
  final Set<String> favoriteIds;
  final bool hasReachedMax;
  final VoidCallback onRefresh;
  final VoidCallback onLoadMore;
  final Function(String) onToggleFavorite;

  const HomeMovieGrid({
    super.key,
    required this.movies,
    required this.favoriteIds,
    required this.hasReachedMax,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            if (!hasReachedMax) {
              onLoadMore();
            }
          }
          return false;
        },
        child: GridView.builder(
          key: const PageStorageKey('movieGrid'),
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: movies.length + (hasReachedMax ? 0 : 1),
          itemBuilder: (context, index) {
            if (index == movies.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                ),
              );
            }
            final movie = movies[index];
            final isFav = favoriteIds.contains(movie.id);
            return MovieCard(
              movie: movie,
              onTap: () {
              },
              onFavoriteTap: () => onToggleFavorite(movie.id),
              isFavorite: isFav,
            );
          },
        ),
      ),
    );
  }
} 