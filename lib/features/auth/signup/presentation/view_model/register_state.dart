import 'package:equatable/equatable.dart';

import '../../domain/model/register_details.dart';

enum RegisterStatus { initial, loading, success, error }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final RegisterDetails? result;
  final String? errorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.result,
    this.errorMessage,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    RegisterDetails? result,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, result, errorMessage];
}
