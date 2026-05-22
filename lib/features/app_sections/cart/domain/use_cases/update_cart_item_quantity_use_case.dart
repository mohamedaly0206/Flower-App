import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartItemQuantityUseCase {
  final CartRepoContract _cartRepoContract;
  UpdateCartItemQuantityUseCase(this._cartRepoContract);

  Future<BaseResponse<CartResponseEntity>> call(
    String productId,
    UpdateCartQuantityRequest
    request, // Change from int to UpdateCartQuantityRequest
  ) async {
    return _cartRepoContract.updateCartItemQuantity(productId, request);
  }
}
