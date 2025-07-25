import 'package:equatable/equatable.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class LoadInitialData extends SplashEvent {
  const LoadInitialData();
}

class HandleSplashLoaded extends SplashEvent {
  final List<MovieModel> movies;
  final bool hasMoreMovies;

  const HandleSplashLoaded({
    required this.movies,
    required this.hasMoreMovies,
  });

  @override
  List<Object?> get props => [movies, hasMoreMovies];
}

class HandleSplashError extends SplashEvent {
  const HandleSplashError();
}
