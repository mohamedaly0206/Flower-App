import 'package:equatable/equatable.dart';
import 'package:flower_app/features/checkout/domain/entities/response/order_entity.dart';

class CheckoutResponseEntity extends Equatable {
  final String? message;
  final OrderEntity? order;

 const  CheckoutResponseEntity({
    this.message,
    this.order,
  });

  @override
  List<Object?> get props => [message, order];
}