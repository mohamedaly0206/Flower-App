import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/response/cart_response_dto.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/cart_repo_contract.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepoContract)
class CartRepoImpl implements CartRepoContract {
  final CartRemoteDataSourceContract _cartRemoteDataSourceContract;
  CartRepoImpl(this._cartRemoteDataSourceContract);
  @override
  Future<BaseResponse<CartResponseEntity>> addItemToCart(
    AddToCartRequest request,
  ) async {
    final response = await _cartRemoteDataSourceContract.addItemToCart(request);
    switch (response) {
      case SuccessBaseResponse<CartResponseDto>():
        return SuccessBaseResponse<CartResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CartResponseDto>():
        return ErrorBaseResponse<CartResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> getCartItems() async {
    final response = await _cartRemoteDataSourceContract.getCartItems();
    switch (response) {
      case SuccessBaseResponse<CartResponseDto>():
        return SuccessBaseResponse<CartResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CartResponseDto>():
        return ErrorBaseResponse<CartResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> removeItemFromCart(
    String productId,
  ) async {
    final response = await _cartRemoteDataSourceContract.removeItemFromCart(
      productId,
    );
    switch (response) {
      case SuccessBaseResponse<CartResponseDto>():
        return SuccessBaseResponse<CartResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CartResponseDto>():
        return ErrorBaseResponse<CartResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<CartResponseEntity>> updateCartItemQuantity(
    String productId,
    UpdateCartQuantityRequest request,
  ) async {
    final response = await _cartRemoteDataSourceContract.updateCartItemQuantity(
      productId,
      UpdateCartQuantityRequest(quantity: request.quantity),
    );
    switch (response) {
      case SuccessBaseResponse<CartResponseDto>():
        return SuccessBaseResponse<CartResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CartResponseDto>():
        return ErrorBaseResponse<CartResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
