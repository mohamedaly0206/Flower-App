// cart_state.dart
import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';

class CartState extends Equatable {
  final BaseState<CartResponseEntity>? getCartItemsState;
  final BaseState<CartResponseEntity>? addItemToCartState;
  final BaseState<CartResponseEntity>? removeItemFromCartState;
  final BaseState<CartResponseEntity>? updateItemQuantityInCartState;

  final Set<String> loadingProductIds;
  final Set<String> deletingProductIds;
  final Set<String> updatingProductIds;

  /// Returns the total number of items in the cart
  int get itemCount => getCartItemsState?.data?.numOfCartItems ?? 0;

  /// Safely extracts the list of cart items
  List<dynamic> get cartItems => getCartItemsState?.data?.cart?.cartItems ?? [];

  /// Checks if the cart is completely empty
  bool get isCartEmpty => cartItems.isEmpty;

  /// Calculates the subtotal of all items in the cart
  double get subTotal {
    double total = 0.0;
    for (var item in cartItems) {
      final price =
          item.product?.priceAfterDiscount ?? item.product?.price ?? 0;
      final quantity = item.quantity ?? 1;
      total += (price * quantity);
    }
    return total;
  }

  /// The delivery fee (can be made dynamic later if needed)
  double get deliveryFee => 10.0;

  /// Calculates the final total price
  double get totalPrice => subTotal + deliveryFee;

  const CartState({
    this.getCartItemsState = const BaseState(),
    this.addItemToCartState = const BaseState(),
    this.removeItemFromCartState = const BaseState(),
    this.updateItemQuantityInCartState = const BaseState(),
    this.loadingProductIds = const {},
    this.deletingProductIds = const {},
    this.updatingProductIds = const {},
  });

  CartState copyWith({
    BaseState<CartResponseEntity>? getCartItemsState,
    BaseState<CartResponseEntity>? addItemToCartState,
    BaseState<CartResponseEntity>? removeItemFromCartState,
    BaseState<CartResponseEntity>? updateItemQuantityInCartState,
    Set<String>? loadingProductIds,
    Set<String>? deletingProductIds,
    Set<String>? updatingProductIds,
  }) {
    return CartState(
      getCartItemsState: getCartItemsState ?? this.getCartItemsState,
      addItemToCartState: addItemToCartState ?? this.addItemToCartState,
      removeItemFromCartState:
          removeItemFromCartState ?? this.removeItemFromCartState,
      updateItemQuantityInCartState:
          updateItemQuantityInCartState ?? this.updateItemQuantityInCartState,
      loadingProductIds: loadingProductIds ?? this.loadingProductIds,
      deletingProductIds: deletingProductIds ?? this.deletingProductIds,
      updatingProductIds: updatingProductIds ?? this.updatingProductIds,
    );
  }

  @override
  List<Object?> get props => [
    getCartItemsState,
    addItemToCartState,
    removeItemFromCartState,
    updateItemQuantityInCartState,
    loadingProductIds,
    deletingProductIds,
    updatingProductIds,
  ];
}
