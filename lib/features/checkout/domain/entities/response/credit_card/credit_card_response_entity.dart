import 'package:equatable/equatable.dart';
import 'package:flower_app/features/checkout/domain/entities/response/credit_card/session_entity.dart';

class CreditCardResponseEntity extends Equatable {
  final String? message;
  final SessionEntity? session;

  const CreditCardResponseEntity({this.message, this.session});

  @override
  List<Object?> get props => [message, session];
}
