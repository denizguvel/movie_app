import 'package:equatable/equatable.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<MovieModel> movies;
  final int currentPage;
  final int totalPages;
  final bool hasReachedMax;
  final Set<String> favoriteIds;

  const HomeLoaded({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    required this.hasReachedMax,
    required this.favoriteIds,
  });

  HomeLoaded copyWith({
    List<MovieModel>? movies,
    int? currentPage,
    int? totalPages,
    bool? hasReachedMax,
    Set<String>? favoriteIds,
  }) {
    return HomeLoaded(
      movies: movies ?? this.movies,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object?> get props => [movies, currentPage, totalPages, hasReachedMax, favoriteIds];
}

class HomeLoadingMore extends HomeState {
  final List<MovieModel> movies;
  final int currentPage;
  final int totalPages;
  final Set<String> favoriteIds;

  const HomeLoadingMore({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
    required this.favoriteIds,
  });

  @override
  List<Object?> get props => [movies, currentPage, totalPages, favoriteIds];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
