import 'package:equatable/equatable.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashLoaded extends SplashState {
  final List<MovieModel> movies;
  final bool hasMoreMovies;

  const SplashLoaded({
    required this.movies,
    required this.hasMoreMovies,
  });

  @override
  List<Object?> get props => [movies, hasMoreMovies];
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object?> get props => [message];
}

class SplashNavigateToLogin extends SplashState {
  const SplashNavigateToLogin();
}
