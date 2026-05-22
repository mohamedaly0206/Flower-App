import 'package:equatable/equatable.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';

sealed class LoginState extends Equatable {
  final bool obscurePassword;
  final bool rememberMe;

  const LoginState({this.obscurePassword = true, this.rememberMe = false});

  @override
  List<Object?> get props => [obscurePassword, rememberMe];
}

class LoginInitial extends LoginState {
  const LoginInitial({super.obscurePassword, super.rememberMe});
}

class LoginLoading extends LoginState {
  const LoginLoading({super.obscurePassword, super.rememberMe});
}

class LoginSuccess extends LoginState {
  final LoginResponse response;

  const LoginSuccess(this.response, {super.obscurePassword, super.rememberMe});

  @override
  List<Object?> get props => [response, obscurePassword, rememberMe];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure(
    this.errorMessage, {
    super.obscurePassword,
    super.rememberMe,
  });

  @override
  List<Object?> get props => [errorMessage, obscurePassword, rememberMe];
}
