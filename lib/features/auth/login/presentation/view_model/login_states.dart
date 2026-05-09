import 'package:equatable/equatable.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';

sealed class LoginState extends Equatable {
  final bool obscurePassword;

  const LoginState({this.obscurePassword = true});

  @override
  List<Object?> get props => [obscurePassword];
}

class LoginInitial extends LoginState {
  const LoginInitial({super.obscurePassword});
}

class LoginLoading extends LoginState {
  const LoginLoading({super.obscurePassword});
}

class LoginSuccess extends LoginState {
  final LoginResponse response;

  const LoginSuccess(this.response, {super.obscurePassword});

  @override
  List<Object?> get props => [response, obscurePassword];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure(this.errorMessage, {super.obscurePassword});

  @override
  List<Object?> get props => [errorMessage, obscurePassword];
}
