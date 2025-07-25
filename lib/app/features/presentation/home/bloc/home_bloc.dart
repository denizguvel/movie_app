import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/features/data/repositories/movies_repository.dart';
import 'package:movie_app/core/result/result.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository _moviesRepository;
  int _page = 1;

  HomeBloc({required MoviesRepository moviesRepository})
      : _moviesRepository = moviesRepository,
        super(const HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<LoadMoviesWithData>(_onLoadMoviesWithData);
    on<RefreshMovies>(_onRefreshMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<ToggleFavorite>(_onToggleFavorite);
    on<ClearFavorites>(_onClearFavorites);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    _page = 1;
    emit(const HomeLoading());
    
    final favResult = await _moviesRepository.getFavoriteMovieIds();
    final favoriteIds = favResult is SuccessDataResult ? Set<String>.from(favResult.data!) : <String>{};
    
    await _fetchMovies(emit, page: _page, append: false, favoriteIds: favoriteIds);
  }

  Future<void> _onLoadMoviesWithData(LoadMoviesWithData event, Emitter<HomeState> emit) async {
    _page = 1;
    
    final favResult = await _moviesRepository.getFavoriteMovieIds();
    final favoriteIds = favResult is SuccessDataResult ? Set<String>.from(favResult.data!) : <String>{};
    
    emit(HomeLoaded(
      movies: event.movies,
      currentPage: _page,
      totalPages: 0,
      hasReachedMax: !event.hasMoreMovies,
      favoriteIds: favoriteIds,
    ));
  }

  Future<void> _onRefreshMovies(RefreshMovies event, Emitter<HomeState> emit) async {
    _page = 1;
    await _fetchMovies(emit, page: _page, append: false);
  }

  Future<void> _onLoadMoreMovies(LoadMoreMovies event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded && !(state as HomeLoaded).hasReachedMax) {
      final currentState = state as HomeLoaded;
      emit(HomeLoadingMore(
        movies: currentState.movies,
        currentPage: _page,
        totalPages: 0,
        favoriteIds: currentState.favoriteIds,
      ));
      _page += 1;
      await _fetchMovies(emit, page: _page, append: true, favoriteIds: currentState.favoriteIds);
    }
  }

  Future<void> _fetchMovies(Emitter<HomeState> emit, {required int page, bool append = false, Set<String>? favoriteIds}) async {
    try {
      final result = await _moviesRepository.getMovieList(page: page);

      if (result is SuccessDataResult) {
        final movieResponse = result.data!;
        final newMovies = movieResponse.movies;
        final hasReachedMax = newMovies.length < 5;

        Set<String> currentFavIds = <String>{};
        if (state is HomeLoaded) {
          currentFavIds = (state as HomeLoaded).favoriteIds;
        } else if (state is HomeLoadingMore) {
          currentFavIds = (state as HomeLoadingMore).favoriteIds;
        } else if (favoriteIds != null) {
          currentFavIds = favoriteIds;
        }

        if (append && (state is HomeLoaded || state is HomeLoadingMore)) {
          final currentMovies = state is HomeLoaded
              ? (state as HomeLoaded).movies
              : (state as HomeLoadingMore).movies;
          final updatedMovies = [...currentMovies, ...newMovies];
          emit(HomeLoaded(
            movies: updatedMovies,
            currentPage: page,
            totalPages: 0,
            hasReachedMax: hasReachedMax,
            favoriteIds: currentFavIds,
          ));
        } else {
          emit(HomeLoaded(
            movies: newMovies,
            currentPage: page,
            totalPages: 0,
            hasReachedMax: hasReachedMax,
            favoriteIds: currentFavIds,
          ));
        }
      } else if (result is ErrorDataResult) {
        emit(HomeError(result.message ?? 'Unknown error'));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final isFav = currentState.favoriteIds.contains(event.movieId);
      
      final updatedFavs = Set<String>.from(currentState.favoriteIds);
      if (isFav) {
        updatedFavs.remove(event.movieId);
      } else {
        updatedFavs.add(event.movieId);
      }
      emit(currentState.copyWith(favoriteIds: updatedFavs));

      final result = await _moviesRepository.addFavorite(favoriteId: event.movieId);

      if (result is ErrorDataResult) {
        emit(currentState);
      } else if (result is SuccessDataResult && result.data == true) {
        if (!isFav) {
          final movie = currentState.movies.firstWhere((m) => m.id == event.movieId, orElse: () => currentState.movies.first);
          getIt<ProfileBloc>().add(ProfileAddFavoriteMovieLocally(movie));
        }
      }
    }
  }

  Future<void> _onClearFavorites(ClearFavorites event, Emitter<HomeState> emit) async {
    emit(const HomeInitial());
  }
}
