import 'package:equatable/equatable.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeaturedContent extends ExploreEvent {
  const LoadFeaturedContent();
}

class ToggleLikeStatus extends ExploreEvent {
  final String movieId;
  final bool isLiked;

  const ToggleLikeStatus({
    required this.movieId,
    required this.isLiked,
  });

  @override
  List<Object?> get props => [movieId, isLiked];
}

class NavigateToHome extends ExploreEvent {
  const NavigateToHome();
}

class NavigateToProfile extends ExploreEvent {
  const NavigateToProfile();
}

class RefreshExploreContent extends ExploreEvent {
  const RefreshExploreContent();
}

class NavigateToHomeWithAnimation extends ExploreEvent {
  const NavigateToHomeWithAnimation();
}

class ToggleMovieLike extends ExploreEvent {
  final String movieId;
  final bool currentIsLiked;

  const ToggleMovieLike({
    required this.movieId,
    required this.currentIsLiked,
  });

  @override
  List<Object?> get props => [movieId, currentIsLiked];
}
