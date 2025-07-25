import 'package:flutter/material.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';
import 'package:movie_app/app/features/presentation/home/widgets/movie_card.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';

class ProfileFavoriteMovies extends StatelessWidget {
  final List<MovieModel> movies;
  final bool isLoading;

  const ProfileFavoriteMovies({
    super.key,
    required this.movies,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (movies.isEmpty) {
      return Text(
        AppStrings.noFavoriteMoviesYet,
        style: const TextStyle(color: Colors.white54),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(
          movie: movie,
          onFavoriteTap: null,
          isFavorite: true,
        );
      },
    );
  }
} 