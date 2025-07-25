// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:movie_app/app/features/presentation/home/view/home_view.dart'
    as _i1;
import 'package:movie_app/app/features/presentation/login/view/login_view.dart'
    as _i2;
import 'package:movie_app/app/features/presentation/profile/view/profile_view.dart'
    as _i3;
import 'package:movie_app/app/features/presentation/profile/view/upload_photo_view.dart'
    as _i6;
import 'package:movie_app/app/features/presentation/signup/view/signup_view.dart'
    as _i4;
import 'package:movie_app/app/features/presentation/splash/view/splash_view.dart'
    as _i5;

/// generated route for
/// [_i1.HomeView]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeView();
    },
  );
}

/// generated route for
/// [_i2.LoginView]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginView();
    },
  );
}

/// generated route for
/// [_i3.ProfileView]
class ProfileRoute extends _i7.PageRouteInfo<void> {
  const ProfileRoute({List<_i7.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.ProfileView();
    },
  );
}

/// generated route for
/// [_i4.SignupView]
class SignupRoute extends _i7.PageRouteInfo<void> {
  const SignupRoute({List<_i7.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignupView();
    },
  );
}

/// generated route for
/// [_i5.SplashView]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SplashView();
    },
  );
}

/// generated route for
/// [_i6.UploadPhotoView]
class UploadPhotoRoute extends _i7.PageRouteInfo<void> {
  const UploadPhotoRoute({List<_i7.PageRouteInfo>? children})
    : super(UploadPhotoRoute.name, initialChildren: children);

  static const String name = 'UploadPhotoRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.UploadPhotoView();
    },
  );
}
