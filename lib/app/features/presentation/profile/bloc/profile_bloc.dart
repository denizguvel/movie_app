import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/features/data/repositories/auth_repository.dart';
import 'package:movie_app/app/features/data/models/auth/upload_image_response.dart';
import 'package:movie_app/app/features/data/datasources/local/auth_local_datasource.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;
  final AuthLocalDatasource localDatasource = AuthLocalDatasourceImpl();
  
  ProfileBloc({required this.authRepository}) : super(ProfileInitial()) {
    on<UploadProfilePhotoRequested>(_onUploadProfilePhotoRequested);
    on<FetchProfileRequested>(_onFetchProfileRequested);
    _initializeProfile();
  }

  void _initializeProfile() {
    final user = localDatasource.getUser();
    final userId = user.id ?? '';
    final photoUrl = localDatasource.getProfilePhotoUrl(userId);
    final userName = user.name ?? user.firstName ?? user.username ?? 'Kullanıcı';
    print('[PROFILE DEBUG] user: ' + user.toMap().toString());
    print('[PROFILE DEBUG] userId: $userId, userName: $userName, photoUrl: $photoUrl');
    emit(ProfileLoaded(photoUrl, user: user, userName: userName, userId: userId));
  }

  Future<void> _onUploadProfilePhotoRequested(
    UploadProfilePhotoRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfilePhotoUploading());
    final result = await authRepository.uploadProfileImage(imageFile: event.imageFile);
    final user = localDatasource.getUser();
    final userId = user.id ?? '';
    print('[PROFILE DEBUG] (upload sonrası) user: ' + user.toMap().toString());
    print('[PROFILE DEBUG] (upload sonrası) userId: $userId, userName: ${user.name}, photoUrl: ${user.photoUrl}');
    if (result.success && result.data != null) {
      print('DEBUG: Yüklenen photoUrl: ${result.data!.photoUrl}');
      await localDatasource.saveProfilePhotoUrl(result.data!.photoUrl, userId);
      // Mevcut state'den user bilgilerini al
      final currentState = state;
      String? userName;
      if (currentState is ProfileLoaded) {
        userName = currentState.userName;
      } else {
        userName = user.name ?? user.firstName ?? user.username ?? 'Kullanıcı';
      }
      emit(ProfileLoaded(result.data!.photoUrl, user: user, userName: userName, userId: userId));
    } else {
      emit(ProfilePhotoUploadFailure(result.message ?? 'Bir hata oluştu.'));
    }
  }

  Future<void> _onFetchProfileRequested(
    FetchProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final result = await authRepository.getProfile();
    if (result.success && result.data != null) {
      final user = result.data!;
      final userId = user.id ?? '';
      final photoUrl = localDatasource.getProfilePhotoUrl(userId);
      final userName = user.name ?? user.firstName ?? user.username ?? 'Kullanıcı';
      print('[PROFILE DEBUG] (fetch) user: ' + user.toMap().toString());
      emit(ProfileLoaded(photoUrl, user: user, userName: userName, userId: userId));
    } else {
      print('[PROFILE DEBUG] (fetch) getProfile failed: ' + (result.message ?? ''));
    }
  }
}
