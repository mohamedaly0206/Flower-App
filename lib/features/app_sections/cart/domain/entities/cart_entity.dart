import 'package:flower_app/features/app_sections/cart/domain/entities/cart_item_entity.dart';

class CartEntity {
  final String? id;
  final String? user;
  final List<CartItemEntity>? cartItems;
  final List<dynamic>? appliedCoupons;
  final double? discount;
  final double? totalPriceAfterDiscount;

  CartEntity({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.discount,
    this.totalPriceAfterDiscount,
  });
}
