import 'package:equatable/equatable.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_item_entity.dart';

class CartEntity extends Equatable {
  final String? id;
  final String? user;
  final List<CartItemEntity>? cartItems;
  final List<dynamic>? appliedCoupons;
  final double? discount;
  final double? totalPriceAfterDiscount;

  const CartEntity({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.discount,
    this.totalPriceAfterDiscount,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    cartItems,
    appliedCoupons,
    discount,
    totalPriceAfterDiscount,
  ];
}
