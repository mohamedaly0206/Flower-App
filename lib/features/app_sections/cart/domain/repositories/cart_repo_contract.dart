import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';

abstract interface class CartRepoContract {
  Future<BaseResponse<CartResponseEntity>> getCartItems();
  Future<BaseResponse<CartResponseEntity>> addItemToCart(
    AddToCartRequest request,
  );
  Future<BaseResponse<CartResponseEntity>> removeItemFromCart(String productId);
  Future<BaseResponse<CartResponseEntity>> updateCartItemQuantity(
    String productId,
    int quantity,
  );
}
