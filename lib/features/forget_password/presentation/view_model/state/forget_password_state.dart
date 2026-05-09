part of '../cubit/forget_password_cubit.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<EnterResetEmailEntity> enterEmailState;
  final BaseState<VerifyResetCodeEntity> verifyResetCodeState;
  final BaseState<ResetPasswordEntity> resetPasswordState;
  final String email;

  const ForgetPasswordState({
    this.email = '',
    this.enterEmailState = const BaseState(),
    this.verifyResetCodeState = const BaseState(),
    this.resetPasswordState = const BaseState(),
  });

  ForgetPasswordState copyWith({
    BaseState<EnterResetEmailEntity>? enterEmailState,
    BaseState<VerifyResetCodeEntity>? verifyResetCodeState,
    BaseState<ResetPasswordEntity>? resetPasswordState,
    String? email,
  }) => ForgetPasswordState(
    enterEmailState: enterEmailState ?? this.enterEmailState,
    verifyResetCodeState: verifyResetCodeState ?? this.verifyResetCodeState,
    resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    email: email ?? this.email,
  );

  @override
  List<Object> get props => [
    enterEmailState,
    verifyResetCodeState,
    resetPasswordState,
    email,
  ];
}
