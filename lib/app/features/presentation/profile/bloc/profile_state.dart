import 'package:movie_app/app/features/data/models/auth/auth_user_model.dart';
import 'package:movie_app/app/features/data/models/movie/movie_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String photoUrl;
  final AuthUserModel user;
  final String? userName;
  final String? userId;
  ProfileLoaded(this.photoUrl, {required this.user, this.userName, this.userId});
}

class ProfileFavoriteMoviesLoaded extends ProfileState {
  final List<MovieModel> favoriteMovies;
  ProfileFavoriteMoviesLoaded(this.favoriteMovies);
}

class ProfilePhotoUploading extends ProfileState {}

class ProfilePhotoUploadSuccess extends ProfileState {
  final String photoUrl;
  ProfilePhotoUploadSuccess(this.photoUrl);
}

class ProfilePhotoUploadFailure extends ProfileState {
  final String error;
  ProfilePhotoUploadFailure(this.error);
}
