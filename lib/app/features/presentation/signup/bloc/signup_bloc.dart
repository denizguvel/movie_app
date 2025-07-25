import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app/features/data/models/auth/signup_model.dart';
import 'package:movie_app/core/result/result.dart';
import 'signup_event.dart';
import 'signup_state.dart';
import 'package:movie_app/app/features/data/repositories/auth_repository.dart';
import 'package:movie_app/app/common/get_it/get_it.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_bloc.dart';
import 'package:movie_app/app/features/presentation/home/bloc/home_event.dart';
import 'package:movie_app/app/features/presentation/profile/bloc/profile_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;
  SignupBloc({required this.authRepository}) : super(const SignupState()) {
    on<SignupEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<SignupNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<SignupPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<SignupSubmitted>((event, emit) async {
      emit(
        state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false, errorMessage: null),
      );
      final signupModel = SignupModel(
        email: state.email,
        name: state.name,
        password: state.password,
      );
      print('[SIGNUP] Request body: ${signupModel.toMap()}');
      final result = await authRepository.signup(signupModel: signupModel);
      print('[SIGNUP] Bloc result: $result');
      print('[SIGNUP] Bloc result runtimeType: ${result.runtimeType}');
      if (result is SuccessDataResult<String>) {
        // Kayıt başarılı olduğunda favori filmleri temizle
        getIt<HomeBloc>().add(const ClearFavorites());
        getIt<ProfileBloc>().resetProfile();
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else if (result is ErrorDataResult) {
        print('[SIGNUP] Error: ${result.message}');
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: result.message));
      } else {
        emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: 'Bilinmeyen hata'));
      }
    });
  }
}
