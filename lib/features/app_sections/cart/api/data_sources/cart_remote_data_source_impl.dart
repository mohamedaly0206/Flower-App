import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/app_sections/cart/api/api_client/cart_api_client.dart';
import 'package:flower_app/features/app_sections/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/response/cart_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSourceContract)
class CartRemoteDataSourceImpl implements CartRemoteDataSourceContract {
  final CartApiClient _cartApiClient;

  CartRemoteDataSourceImpl(this._cartApiClient);
  @override
  Future<BaseResponse<CartResponseDto>> addItemToCart(
    AddToCartRequest request,
  ) async {
    try {
      final response = await _cartApiClient.addItemToCart(request);
      return SuccessBaseResponse<CartResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CartResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<CartResponseDto>> getCartItems() async {
    try {
      final response = await _cartApiClient.getCartItems();
      return SuccessBaseResponse<CartResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CartResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<CartResponseDto>> removeItemFromCart(
    String productId,
  ) async {
    try {
      final response = await _cartApiClient.removeItemFromCart(productId);
      return SuccessBaseResponse<CartResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CartResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<CartResponseDto>> updateCartItemQuantity(
    String productId,
    UpdateCartQuantityRequest request,
  ) async {
    try {
      final response = await _cartApiClient.updateCartItemQuantity(
        productId,
        UpdateCartQuantityRequest(quantity: request.quantity),
      );
      return SuccessBaseResponse<CartResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CartResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
