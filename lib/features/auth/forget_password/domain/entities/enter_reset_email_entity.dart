import 'package:equatable/equatable.dart';

class EnterResetEmailEntity extends Equatable {
  final String message;
  final String info;

  const EnterResetEmailEntity({required this.message, required this.info});

  @override
  List<Object?> get props => [message, info];
}
