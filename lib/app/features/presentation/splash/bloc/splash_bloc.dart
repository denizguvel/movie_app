import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_event.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/app/features/data/repositories/movies_repository.dart';
import 'package:movie_app/app/features/presentation/splash/bloc/splash_event.dart';
import 'package:movie_app/app/features/presentation/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final MoviesRepository _moviesRepository;
  bool _isLoading = false;

  SplashBloc({
    required MoviesRepository moviesRepository,
  })  : _moviesRepository = moviesRepository,
        super(const SplashInitial()) {
    on<LoadInitialData>(onLoadInitialData);
    on<HandleSplashLoaded>(onHandleSplashLoaded);
    on<HandleSplashError>(onHandleSplashError);
  }

  Future<void> onLoadInitialData(
    LoadInitialData event,
    Emitter<SplashState> emit,
  ) async {
    if (_isLoading) return;
    
    _isLoading = true;
    emit(const SplashLoading());
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final movieResult = await _moviesRepository.getMovieList(page: 1);
      
      if (movieResult is SuccessDataResult) {
        final hasMoreMovies = movieResult.data!.currentPage < movieResult.data!.totalPages;
        emit(SplashLoaded(
          movies: movieResult.data!.movies,
          hasMoreMovies: hasMoreMovies,
        ));
        
        add(HandleSplashLoaded(
          movies: movieResult.data!.movies,
          hasMoreMovies: hasMoreMovies,
        ));
      } else {
        final errorMessage = (movieResult as ErrorDataResult).message;
        emit(SplashError(errorMessage!));
        
        add(const HandleSplashError());
      }
    } catch (e) {
      emit(SplashError(AppStrings.movieLoadingError));
      add(const HandleSplashError());
    } finally {
      _isLoading = false;
    }
  }

  Future<void> onHandleSplashLoaded(
    HandleSplashLoaded event,
    Emitter<SplashState> emit,
  ) async {
    getIt<HomeBloc>().add(LoadMoviesWithData(
      movies: event.movies,
      hasMoreMovies: event.hasMoreMovies,
    ));
    
    await Future.delayed(const Duration(seconds: 2));
    emit(const SplashNavigateToLogin());
  }

  Future<void> onHandleSplashError(
    HandleSplashError event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(const SplashNavigateToLogin());
  }
}
