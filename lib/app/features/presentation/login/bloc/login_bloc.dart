import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/features/data/models/auth/login_model.dart';
import 'package:movie_app/app/features/data/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:movie_app/core/result/result.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_event.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false, errorMessage: null));
      final loginModel = LoginModel(
        email: state.email,
        password: state.password,
      );
      final result = await authRepository.login(loginModel: loginModel);
      if (result is SuccessDataResult<String>) {
        // Giriş başarılı olduğunda favori filmleri temizle
        getIt<HomeBloc>().add(const ClearFavorites());
        getIt<ProfileBloc>().resetProfile();
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else if (result is ErrorDataResult) {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: result.message));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'Bilinmeyen hata'));
      }
    });
  }
}
