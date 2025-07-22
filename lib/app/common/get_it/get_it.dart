

import 'package:get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.dart';

final getIt = GetIt.instance;

/// **Service provider class managing all dependencies**
final class ServiceLocator {
  /// **Main method to call to set up dependencies**
  void setup() {
    _setupRouter();
    _setupDataSource();
    _setupRepository();
    // _setupCubit();
  }

  /// **Router Dependency**
  void _setupRouter() {
    getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  }

  /// **DataSource Dependency**
  void _setupDataSource() {
    // getIt
    //   ..registerLazySingleton<AccountRemoteDatasource>(
    //     () => AccountRemoteDatasourceImpl(),
    //   )
    //   ..registerLazySingleton<AuthRemoteDatasource>(
    //     () => AuthRemoteDatasourceImpl(),
    //   );
  }

  /// **Repository Dependency**
  void _setupRepository() {
    // getIt
    //   ..registerLazySingleton<AuthRepository>(
    //     () => AuthRepositoryImpl(
    //       remoteDatasource: getIt(),
    //       localDatasource: getIt(),
    //     ),
    //   )
    //   ..registerLazySingleton<ContentRepository>(
    //     () => ContentRepositoryImpl(
    //       remoteDatasource: getIt(),
    //     ),
    //   );

  }

  /// **BLoC, Cubit and ViewModel Dependency**
  // void _setupCubit() {
  //   getIt
  //     ..registerLazySingleton<OnboardingCubit>(
  //       () => OnboardingCubit(),
  //     )
  //     ..registerLazySingleton<MainCubit>(
  //       () => MainCubit(),
  //     )
  // }

  /// **Resets dependencies for Test and Debug**
  Future<void> reset() async {
    await getIt.reset();
    setup();
  }
}
