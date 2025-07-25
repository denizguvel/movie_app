import 'package:get_it/get_it.dart';
import 'package:movie_app/app/common/router/app_router.dart';
import 'package:movie_app/app/common/widgets/bottom_navbar/app_bottom_navbar_bloc.dart';
import 'package:movie_app/app/features/data/datasources/remote/auth_remote_datasource.dart';
import 'package:movie_app/app/features/data/datasources/remote/movies_remote_datasource.dart';
import 'package:movie_app/app/features/data/datasources/local/auth_local_datasource.dart';
import 'package:movie_app/app/features/data/repositories/auth_repository.dart';
import 'package:movie_app/app/features/data/repositories/movies_repository.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_bloc.dart';
import 'package:movie_app/app/features/presentation/signup/bloc/signup_bloc.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:movie_app/app/features/presentation/login/bloc/login_bloc.dart';
import 'package:movie_app/app/features/presentation/explore/bloc/explore_bloc.dart';

final getIt = GetIt.instance;

/// **Service provider class managing all dependencies**
final class ServiceLocator {
  /// **Main method to call to set up dependencies**
  void setup() {
    _setupRouter();
    _setupDataSource();
    _setupRepository();
    _setupBloc();
  }

  /// **Router Dependency**
  void _setupRouter() {
    getIt.registerLazySingleton<AppRouter>(() => AppRouter());
  }

  /// **DataSource Dependency**
  void _setupDataSource() {
    getIt.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(),
    );
    getIt.registerLazySingleton<AuthLocalDatasource>(
      () => AuthLocalDatasourceImpl(),
    );
    getIt.registerLazySingleton<MoviesRemoteDatasource>(
      () => MoviesRemoteDatasourceImpl(),
    );
  }

  /// **Repository Dependency**
  void _setupRepository() {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDatasource: getIt(),
        localDatasource: getIt(),
      ),
    );
    getIt.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(
        remoteDatasource: getIt(),
      ),
    );
  }

  /// **BLoC Dependency**
  void _setupBloc() {
    getIt.registerFactory<SignupBloc>(
      () => SignupBloc(authRepository: getIt()),
    );
    getIt.registerFactory<LoginBloc>(() => LoginBloc(authRepository: getIt()));
    getIt.registerLazySingleton<AppBottomNavbarBloc>(
      () => AppBottomNavbarBloc(),
    );
    getIt.registerFactory<ProfileBloc>(
      () => ProfileBloc(authRepository: getIt()),
    );
    getIt.registerFactory<HomeBloc>(
      () => HomeBloc(moviesRepository: getIt()),
    );
    getIt.registerFactory<ExploreBloc>(
      () => ExploreBloc(),
    );
  }

  /// **Resets dependencies for Test and Debug**
  Future<void> reset() async {
    await getIt.reset();
    setup();
  }
}
