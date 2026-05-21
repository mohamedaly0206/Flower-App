import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/response/cart_response_dto.dart';

abstract interface class CartRemoteDataSourceContract {
  Future<BaseResponse<CartResponseDto>> getCartItems();
  Future<BaseResponse<CartResponseDto>> addItemToCart(AddToCartRequest request);
  Future<BaseResponse<CartResponseDto>> removeItemFromCart(String productId);
  Future<BaseResponse<CartResponseDto>> updateCartItemQuantity(
    String productId,
    int quantity,
  );
}
