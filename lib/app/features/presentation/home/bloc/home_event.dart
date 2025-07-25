import 'package:equatable/equatable.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovies extends HomeEvent {
  const LoadMovies();
}

class LoadMoviesWithData extends HomeEvent {
  final List<MovieModel> movies;
  final bool hasMoreMovies;

  const LoadMoviesWithData({
    required this.movies,
    required this.hasMoreMovies,
  });

  @override
  List<Object?> get props => [movies, hasMoreMovies];
}

class RefreshMovies extends HomeEvent {
  const RefreshMovies();
}

class LoadMoreMovies extends HomeEvent {
  const LoadMoreMovies();
}

class ToggleFavorite extends HomeEvent {
  final String movieId;
  const ToggleFavorite(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class ClearFavorites extends HomeEvent {
  const ClearFavorites();
}
