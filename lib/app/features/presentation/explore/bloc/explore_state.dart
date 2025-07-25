import 'package:equatable/equatable.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

class ExploreInitial extends ExploreState {
  const ExploreInitial();
}

class ExploreLoading extends ExploreState {
  const ExploreLoading();
}

class ExploreLoaded extends ExploreState {
  final String featuredMovieTitle;
  final String featuredMovieDescription;
  final String featuredMovieId;
  final bool isLiked;
  final String? errorMessage;

  const ExploreLoaded({
    required this.featuredMovieTitle,
    required this.featuredMovieDescription,
    required this.featuredMovieId,
    this.isLiked = false,
    this.errorMessage,
  });

  ExploreLoaded copyWith({
    String? featuredMovieTitle,
    String? featuredMovieDescription,
    String? featuredMovieId,
    bool? isLiked,
    String? errorMessage,
  }) {
    return ExploreLoaded(
      featuredMovieTitle: featuredMovieTitle ?? this.featuredMovieTitle,
      featuredMovieDescription: featuredMovieDescription ?? this.featuredMovieDescription,
      featuredMovieId: featuredMovieId ?? this.featuredMovieId,
      isLiked: isLiked ?? this.isLiked,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        featuredMovieTitle,
        featuredMovieDescription,
        featuredMovieId,
        isLiked,
        errorMessage,
      ];
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError(this.message);

  @override
  List<Object?> get props => [message];
}

class ExploreLikeStatusUpdated extends ExploreState {
  final String movieId;
  final bool isLiked;

  const ExploreLikeStatusUpdated({
    required this.movieId,
    required this.isLiked,
  });

  @override
  List<Object?> get props => [movieId, isLiked];
}
