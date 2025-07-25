import 'package:auto_route/auto_route.dart';
import 'package:movie_app/app/common/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    CustomRoute(
      page: LoginRoute.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: const Duration(milliseconds: 700),
    ),
    AutoRoute(page: SignupRoute.page),
    AutoRoute(page: ExploreRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: UploadPhotoRoute.page),
  ];
}
