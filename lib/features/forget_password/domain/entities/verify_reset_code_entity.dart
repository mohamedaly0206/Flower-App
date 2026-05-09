import 'package:equatable/equatable.dart';

class VerifyResetCodeEntity extends Equatable {
  final String status;

  const VerifyResetCodeEntity({required this.status});

  @override
  List<Object?> get props => [status];
}
