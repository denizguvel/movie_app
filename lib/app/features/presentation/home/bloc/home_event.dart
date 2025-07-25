import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadMovies extends HomeEvent {
  const LoadMovies();
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
