import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/features/data/repositories/auth_repository.dart';
import 'package:movie_app/app/features/data/repositories/movies_repository.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';
import 'package:movie_app/app/features/data/datasources/local/auth_local_datasource.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/common/constants/app_strings.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_event.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_state.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileAddFavoriteMovieLocally extends ProfileEvent {
  final MovieModel movie;
  ProfileAddFavoriteMovieLocally(this.movie);
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;
  final MoviesRepository moviesRepository = getIt<MoviesRepository>();
  final AuthLocalDatasource localDatasource = AuthLocalDatasourceImpl();
  final List<MovieModel> localFavoriteMovies = [];
  
  ProfileBloc({required this.authRepository}) : super(ProfileInitial()) {
    on<UploadProfilePhotoRequested>(_onUploadProfilePhotoRequested);
    on<FetchProfileRequested>(_onFetchProfileRequested);
    on<FetchFavoriteMoviesRequested>(_onFetchFavoriteMoviesRequested);
    on<ProfileAddFavoriteMovieLocally>(_onAddFavoriteMovieLocally);
    on<UploadProfilePhotoFileRequested>(_onUploadProfilePhotoFileRequested);
    on<PickProfilePhotoRequested>(_onPickProfilePhotoRequested);
    initializeProfile();
  }

  void clearLocalFavorites() {
    localFavoriteMovies.clear();
  }

  void resetProfile() {
    localFavoriteMovies.clear();
    add(FetchProfileRequested());
  }

  void initializeProfile() {
    add(FetchProfileRequested());
  }

  Future<void> _onUploadProfilePhotoRequested(
    UploadProfilePhotoRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfilePhotoUploading());
    final result = await authRepository.uploadProfileImage(imageFile: event.imageFile);
    final user = localDatasource.getUser();
    final userId = user.id ?? '';
    
    if (result.success && result.data != null) {
      await localDatasource.saveProfilePhotoUrl(result.data!.photoUrl, userId);
      
      final profileResult = await authRepository.getProfile();
      if (profileResult.success && profileResult.data != null) {
        final updatedUser = profileResult.data!;
        final updatedUserId = updatedUser.id ?? '';
        
        String updatedPhotoUrl = localDatasource.getProfilePhotoUrl(updatedUserId);
        if (updatedPhotoUrl.isEmpty && updatedUser.photoUrl != null && updatedUser.photoUrl!.isNotEmpty) {
          updatedPhotoUrl = updatedUser.photoUrl!;
          await localDatasource.saveProfilePhotoUrl(updatedPhotoUrl, updatedUserId);
        }
        
        final updatedUserName = updatedUser.name ?? updatedUser.firstName ?? updatedUser.username ?? AppStrings.user;
        
        emit(ProfileLoaded(updatedPhotoUrl, user: updatedUser, userName: updatedUserName, userId: updatedUserId));
      } else {
        final currentState = state;
        String? userName;
        if (currentState is ProfileLoaded) {
          userName = currentState.userName;
        } else {
          userName = user.name ?? user.firstName ?? user.username ?? AppStrings.user;
        }
        emit(ProfileLoaded(result.data!.photoUrl, user: user, userName: userName, userId: userId));
      }
      
      emit(ProfilePhotoUploadSuccess(result.data!.photoUrl));
    } else {
      emit(ProfilePhotoUploadFailure(result.message ?? AppStrings.anErrorOccurred));
    }
  }

  Future<void> _onUploadProfilePhotoFileRequested(
    UploadProfilePhotoFileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfilePhotoUploading());
    final result = await authRepository.uploadProfileImage(imageFile: event.imageFile);
    final user = localDatasource.getUser();
    final userId = user.id ?? '';
    
    if (result.success && result.data != null) {
      await localDatasource.saveProfilePhotoUrl(result.data!.photoUrl, userId);
      
      final profileResult = await authRepository.getProfile();
      if (profileResult.success && profileResult.data != null) {
        final updatedUser = profileResult.data!;
        final updatedUserId = updatedUser.id ?? '';
        
        String updatedPhotoUrl = localDatasource.getProfilePhotoUrl(updatedUserId);
        if (updatedPhotoUrl.isEmpty && updatedUser.photoUrl != null && updatedUser.photoUrl!.isNotEmpty) {
          updatedPhotoUrl = updatedUser.photoUrl!;
          await localDatasource.saveProfilePhotoUrl(updatedPhotoUrl, updatedUserId);
        }
        
        final updatedUserName = updatedUser.name ?? updatedUser.firstName ?? updatedUser.username ?? AppStrings.user;
        
        emit(ProfileLoaded(updatedPhotoUrl, user: updatedUser, userName: updatedUserName, userId: updatedUserId));
      } else {
        final currentState = state;
        String? userName;
        if (currentState is ProfileLoaded) {
          userName = currentState.userName;
        } else {
          userName = user.name ?? user.firstName ?? user.username ?? AppStrings.user;
        }
        emit(ProfileLoaded(result.data!.photoUrl, user: user, userName: userName, userId: userId));
      }
      emit(ProfilePhotoUploadSuccess(result.data!.photoUrl));
    } else {
      emit(ProfilePhotoUploadFailure(result.message ?? AppStrings.anErrorOccurred));
    }
  }

  Future<void> _onPickProfilePhotoRequested(
    PickProfilePhotoRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );
    if (picked != null) {
      add(UploadProfilePhotoFileRequested(File(picked.path)));
    }
  }

  Future<void> _onFetchProfileRequested(
    FetchProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final token = localDatasource.getToken();
    if (token.isEmpty) {
      return;
    }
    
    final result = await authRepository.getProfile();
    if (result.success && result.data != null) {
      final user = result.data!;
      final userId = user.id ?? '';
      
      String photoUrl = localDatasource.getProfilePhotoUrl(userId);
      if (photoUrl.isEmpty && user.photoUrl != null && user.photoUrl!.isNotEmpty) {
        photoUrl = user.photoUrl!;
        await localDatasource.saveProfilePhotoUrl(photoUrl, userId);
      }
      
      final userName = user.name ?? user.firstName ?? user.username ?? AppStrings.user;
      emit(ProfileLoaded(photoUrl, user: user, userName: userName, userId: userId));
    }
  }

  Future<void> _onFetchFavoriteMoviesRequested(
    FetchFavoriteMoviesRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final token = localDatasource.getToken();
    if (token.isEmpty) {
      emit(ProfileFavoriteMoviesLoaded(localFavoriteMovies));
      return;
    }
    
    final result = await moviesRepository.getFavoriteMovies();
    if (result.success && result.data != null) {
      final backendMovies = result.data!;
      final allMovies = [...backendMovies];
      for (final localMovie in localFavoriteMovies) {
        if (!allMovies.any((m) => m.id == localMovie.id)) {
          allMovies.insert(0, localMovie);
        }
      }
      emit(ProfileFavoriteMoviesLoaded(allMovies));
    } else {
      emit(ProfileFavoriteMoviesLoaded(localFavoriteMovies));
    }
  }

  void _onAddFavoriteMovieLocally(ProfileAddFavoriteMovieLocally event, Emitter<ProfileState> emit) {
    if (!localFavoriteMovies.any((m) => m.id == event.movie.id)) {
      localFavoriteMovies.add(event.movie);

      final currentState = state;
      if (currentState is ProfileFavoriteMoviesLoaded) {
        final allMovies = [...currentState.favoriteMovies];
        allMovies.add(event.movie);
        emit(ProfileFavoriteMoviesLoaded(allMovies));
      } else {
        emit(ProfileFavoriteMoviesLoaded(localFavoriteMovies));
      }
    }
  }
}
