import 'dart:io';

abstract class ProfileEvent {}

class UploadProfilePhotoRequested extends ProfileEvent {
  final File imageFile;
  UploadProfilePhotoRequested(this.imageFile);
}

class FetchProfileRequested extends ProfileEvent {}
