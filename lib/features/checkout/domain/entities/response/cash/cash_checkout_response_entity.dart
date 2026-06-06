import 'package:equatable/equatable.dart';
import 'package:flower_app/features/checkout/domain/entities/response/cash/order_entity.dart';

class CashCheckoutResponseEntity extends Equatable {
  final String? message;
  final OrderEntity? order;

  const CashCheckoutResponseEntity({this.message, this.order});

  @override
  List<Object?> get props => [message, order];
}
