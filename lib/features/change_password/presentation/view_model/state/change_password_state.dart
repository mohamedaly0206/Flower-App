part of '../cubit/change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordResponseEntity> changePasswordState;

  const ChangePasswordState({this.changePasswordState = const BaseState()});

  ChangePasswordState copyWith({
    BaseState<ChangePasswordResponseEntity>? changePasswordState,
  }) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }

  @override
  List<Object?> get props => [changePasswordState];
}
