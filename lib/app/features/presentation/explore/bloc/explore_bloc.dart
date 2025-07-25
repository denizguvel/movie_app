import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar_bloc.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_event.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(const ExploreInitial()) {
    on<LoadFeaturedContent>(onLoadFeaturedContent);
    on<ToggleLikeStatus>(onToggleLikeStatus);
    on<NavigateToHome>(onNavigateToHome);
    on<NavigateToProfile>(onNavigateToProfile);
    on<RefreshExploreContent>(onRefreshExploreContent);
    on<NavigateToHomeWithAnimation>(onNavigateToHomeWithAnimation);
    on<ToggleMovieLike>(onToggleMovieLike);
  }

  Future<void> onLoadFeaturedContent(
    LoadFeaturedContent event,
    Emitter<ExploreState> emit,
  ) async {
    emit(const ExploreLoading());
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      emit(ExploreLoaded(
        featuredMovieTitle: AppStrings.featuredMovieTitle,
        featuredMovieDescription: AppStrings.featuredMovieDescription,
        featuredMovieId: AppStrings.featuredMovieId,
        isLiked: false,
      ));
    } catch (e) {
      emit(ExploreError(AppStrings.exploreError));
    }
  }

  Future<void> onToggleLikeStatus(
    ToggleLikeStatus event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      final currentState = state;
      if (currentState is ExploreLoaded) {
        emit(currentState.copyWith(isLiked: event.isLiked));
        emit(ExploreLikeStatusUpdated(
          movieId: event.movieId,
          isLiked: event.isLiked,
        ));
      }
    } catch (e) {
      final currentState = state;
      if (currentState is ExploreLoaded) {
        emit(currentState.copyWith(errorMessage: AppStrings.anErrorOccurred));
      }
    }
  }

  void onNavigateToHome(
    NavigateToHome event,
    Emitter<ExploreState> emit,
  ) {
    getIt<AppBottomNavbarBloc>().add(AppBottomNavbarEvent.Home);
  }

  void onNavigateToProfile(
    NavigateToProfile event,
    Emitter<ExploreState> emit,
  ) {
    getIt<AppBottomNavbarBloc>().add(AppBottomNavbarEvent.Profile);
  }

  Future<void> onRefreshExploreContent(
    RefreshExploreContent event,
    Emitter<ExploreState> emit,
  ) async {
    add(const LoadFeaturedContent());
  }

  void onNavigateToHomeWithAnimation(
    NavigateToHomeWithAnimation event,
    Emitter<ExploreState> emit,
  ) {
    getIt<AppBottomNavbarBloc>().add(AppBottomNavbarEvent.Home);
  }

  Future<void> onToggleMovieLike(
    ToggleMovieLike event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      final currentState = state;
      if (currentState is ExploreLoaded) {
        final newIsLiked = !event.currentIsLiked;
        emit(currentState.copyWith(isLiked: newIsLiked));
        emit(ExploreLikeStatusUpdated(
          movieId: event.movieId,
          isLiked: newIsLiked,
        ));
      }
    } catch (e) {
      final currentState = state;
      if (currentState is ExploreLoaded) {
        emit(currentState.copyWith(errorMessage: AppStrings.anErrorOccurred));
      }
    }
  }
}
