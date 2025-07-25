import 'dart:io';

abstract class ProfileEvent {}

class UploadProfilePhotoRequested extends ProfileEvent {
  final File imageFile;
  UploadProfilePhotoRequested(this.imageFile);
}

class UploadProfilePhotoFileRequested extends ProfileEvent {
  final File imageFile;
  UploadProfilePhotoFileRequested(this.imageFile);
}

class FetchProfileRequested extends ProfileEvent {}

class FetchFavoriteMoviesRequested extends ProfileEvent {}

class PickProfilePhotoRequested extends ProfileEvent {}
