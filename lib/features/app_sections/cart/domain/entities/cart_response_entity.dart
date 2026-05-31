import 'package:equatable/equatable.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_entity.dart';

class CartResponseEntity extends Equatable {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const CartResponseEntity({this.message, this.numOfCartItems, this.cart});

  @override
  List<Object?> get props => [message, numOfCartItems, cart];
}
