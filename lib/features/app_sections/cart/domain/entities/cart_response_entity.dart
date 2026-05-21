import 'package:flower_app/features/app_sections/cart/domain/entities/cart_entity.dart';

class CartResponseEntity {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  CartResponseEntity({this.message, this.numOfCartItems, this.cart});
}
