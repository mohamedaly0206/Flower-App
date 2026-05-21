import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/cart_repo_contract.dart';

class UpdateCartItemQuantityUseCase {
  final CartRepoContract _cartRepoContract;
  UpdateCartItemQuantityUseCase(this._cartRepoContract);
  Future<BaseResponse<CartResponseEntity>> call(String productId, int request) async {
    return _cartRepoContract.updateCartItemQuantity(productId, request);
  }
}