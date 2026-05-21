import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';

class CartState extends Equatable {
  final BaseState<CartResponseEntity>? getCartItemsState;
  final BaseState<CartResponseEntity>? addItemToCartState;
  final BaseState<CartResponseEntity>? removeItemFromCartState;
  final BaseState<CartResponseEntity>? updateItemQuantityInCartState;
  const CartState({
    this.getCartItemsState = const BaseState(),
    this.addItemToCartState = const BaseState(),
    this.removeItemFromCartState = const BaseState(),
    this.updateItemQuantityInCartState = const BaseState(),
  });

  CartState copyWith({
    BaseState<CartResponseEntity>? getCartItemsState,
    BaseState<CartResponseEntity>? addItemToCartState,
    BaseState<CartResponseEntity>? removeItemFromCartState,
    BaseState<CartResponseEntity>? updateItemQuantityInCartState,
  }) {
    return CartState(
      getCartItemsState: getCartItemsState ?? this.getCartItemsState,
      addItemToCartState: addItemToCartState ?? this.addItemToCartState,
      removeItemFromCartState:
          removeItemFromCartState ?? this.removeItemFromCartState,
      updateItemQuantityInCartState:
          updateItemQuantityInCartState ?? this.updateItemQuantityInCartState,
    );
  }

  @override
  List<Object?> get props => [
    getCartItemsState,
    addItemToCartState,
    removeItemFromCartState,
    updateItemQuantityInCartState,
  ];
}
