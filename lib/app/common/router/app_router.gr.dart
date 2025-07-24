// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:movie_app/app/features/presentation/login/view/login_view.dart'
    as _i1;
import 'package:movie_app/app/features/presentation/signup/view/signup_view.dart'
    as _i2;
import 'package:movie_app/app/features/presentation/splash/view/splash_view.dart'
    as _i3;
import 'package:movie_app/app/features/presentation/home/view/home_view.dart' as _i4;

/// generated route for
/// [_i1.LoginView]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute({List<_i4.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.LoginView();
    },
  );
}

/// generated route for
/// [_i2.SignupView]
class SignupRoute extends _i4.PageRouteInfo<void> {
  const SignupRoute({List<_i4.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.SignupView();
    },
  );
}

/// generated route for
/// [_i3.SplashView]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashView();
    },
  );
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeView();
    },
  );
}
