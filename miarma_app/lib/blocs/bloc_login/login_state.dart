part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends LoginState {}

class RegisterLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponse loginResponse;

  const LoginSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class LoginErrorState extends LoginState {
  final String message;

  const LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}
