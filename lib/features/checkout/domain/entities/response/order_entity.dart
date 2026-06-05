import 'package:equatable/equatable.dart';
import 'package:flower_app/features/checkout/domain/entities/response/order_item_entity.dart';

class OrderEntity extends Equatable {
  final String? user;
  final List<OrderItemEntity>? orderItems;
  final double? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? id;
  final String? orderNumber;
  const OrderEntity({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.orderNumber,
  });

  @override
  List<Object?> get props => [
    user,
    orderItems,
    totalPrice,
    paymentType,
    isPaid,
    isDelivered,
    state,
    id,
    orderNumber,
  ];
}
