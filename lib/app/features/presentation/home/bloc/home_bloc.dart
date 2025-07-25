import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/features/data/repositories/movies_repository.dart';
import 'package:movie_app/core/result/result.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_bloc.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_event.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository _moviesRepository;
  int _page = 1;

  HomeBloc({required MoviesRepository moviesRepository})
      : _moviesRepository = moviesRepository,
        super(const HomeInitial()) {
    on<LoadMovies>(_onLoadMovies);
    on<RefreshMovies>(_onRefreshMovies);
    on<LoadMoreMovies>(_onLoadMoreMovies);
    on<ToggleFavorite>(_onToggleFavorite);
    on<ClearFavorites>(_onClearFavorites);
  }

  Future<void> _onLoadMovies(LoadMovies event, Emitter<HomeState> emit) async {
    _page = 1;
    emit(const HomeLoading());
    
    // İlk yüklemede favori id'lerini çek
    final favResult = await _moviesRepository.getFavoriteMovieIds();
    final favoriteIds = favResult is SuccessDataResult ? Set<String>.from(favResult.data!) : <String>{};
    
    await _fetchMovies(emit, page: _page, append: false, favoriteIds: favoriteIds);
  }

  Future<void> _onRefreshMovies(RefreshMovies event, Emitter<HomeState> emit) async {
    _page = 1;
    await _fetchMovies(emit, page: _page, append: false);
  }

  Future<void> _onLoadMoreMovies(LoadMoreMovies event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded && !(state as HomeLoaded).hasReachedMax) {
      emit(HomeLoadingMore(
        movies: (state as HomeLoaded).movies,
        currentPage: _page,
        totalPages: 0,
      ));
      _page += 1;
      await _fetchMovies(emit, page: _page, append: true);
    }
  }

  Future<void> _fetchMovies(Emitter<HomeState> emit, {required int page, bool append = false, Set<String>? favoriteIds}) async {
    try {
      print('DEBUG: Fetching movies for page: $page, append: $append, state: $state');
      final result = await _moviesRepository.getMovieList(page: page);

      if (result is SuccessDataResult) {
        final movieResponse = result.data!;
        final newMovies = movieResponse.movies;
        final hasReachedMax = newMovies.length < 5;

        // Favori durumunu mevcut state'den al
        Set<String> currentFavIds = <String>{};
        if (state is HomeLoaded) {
          currentFavIds = (state as HomeLoaded).favoriteIds;
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
          print('DEBUG: emit HomeLoaded (append), movies.length = ${updatedMovies.length}');
        } else {
          emit(HomeLoaded(
            movies: newMovies,
            currentPage: page,
            totalPages: 0,
            hasReachedMax: hasReachedMax,
            favoriteIds: currentFavIds,
          ));
          print('DEBUG: emit HomeLoaded (ilk yükleme/refresh), movies.length = ${newMovies.length}');
        }
      } else if (result is ErrorDataResult) {
        print('DEBUG: Error result: ${result.message}');
        emit(HomeError(result.message ?? 'Unknown error'));
      }
    } catch (e) {
      print('DEBUG: Exception in _fetchMovies: $e');
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      final isFav = currentState.favoriteIds.contains(event.movieId);
      
      // 1. Optimistic update: UI'da hemen değiştir
      final updatedFavs = Set<String>.from(currentState.favoriteIds);
      if (isFav) {
        updatedFavs.remove(event.movieId);
      } else {
        updatedFavs.add(event.movieId);
      }
      emit(currentState.copyWith(favoriteIds: updatedFavs));

      // 2. Backend isteği
      final result = await _moviesRepository.addFavorite(favoriteId: event.movieId);

      // 3. Backend'den hata gelirse eski haline döndür
      if (result is ErrorDataResult) {
        emit(currentState); // Eski state'e geri dön
      } else if (result is SuccessDataResult && result.data == true) {
        // Sadece favori eklendiyse ProfileBloc'a event gönder
        if (!isFav) {
          final movie = currentState.movies.firstWhere((m) => m.id == event.movieId, orElse: () => currentState.movies.first);
          getIt<ProfileBloc>().add(ProfileAddFavoriteMovieLocally(movie));
        }
      }
    }
  }

  Future<void> _onClearFavorites(ClearFavorites event, Emitter<HomeState> emit) async {
    // State'i tamamen temizle ve initial state'e dön
    emit(const HomeInitial());
  }
}
