import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
  @override
  List<Object?> get props => [];
}

class SignupEmailChanged extends SignupEvent {
  final String email;
  const SignupEmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class SignupNameChanged extends SignupEvent {
  final String name;
  const SignupNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class SignupPasswordChanged extends SignupEvent {
  final String password;
  const SignupPasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class TogglePasswordVisibility extends SignupEvent {}

class TogglePasswordAgainVisibility extends SignupEvent {}

class SignupSubmitted extends SignupEvent {}
