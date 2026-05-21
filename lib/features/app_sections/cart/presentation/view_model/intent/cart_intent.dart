import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';

sealed class CartIntent {}

class GetCartItemsIntent extends CartIntent {}

class RemoveItemFromCartIntent extends CartIntent {
  final String productId;
  RemoveItemFromCartIntent({required this.productId});
}

class UpdateCartItemQuantityIntent extends CartIntent {
  final String productId;
  final int quantity;
  UpdateCartItemQuantityIntent({
    required this.productId,
    required this.quantity,
  });
}

class AddItemToCartIntent extends CartIntent {
  final AddToCartRequest request;
  AddItemToCartIntent({required this.request});
}
