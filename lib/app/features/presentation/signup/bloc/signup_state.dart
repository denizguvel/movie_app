import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String email;
  final String name;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? errorMessage;
  final bool isPasswordVisible;
  final bool isPasswordAgainVisible;

  const SignupState({
    this.email = '',
    this.name = '',
    this.password = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errorMessage,
    this.isPasswordVisible = false,
    this.isPasswordAgainVisible = false,
  });

  SignupState copyWith({
    String? email,
    String? name,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    bool? isPasswordVisible,
    bool? isPasswordAgainVisible,
  }) {
    return SignupState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isPasswordAgainVisible: isPasswordAgainVisible ?? this.isPasswordAgainVisible,
    );
  }

  @override
  List<Object?> get props => [email, name, password, isSubmitting, isSuccess, isFailure, errorMessage, isPasswordVisible, isPasswordAgainVisible];
}
