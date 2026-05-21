import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/cart_repo_contract.dart';

class GetItemsCartUseCase {
  GetItemsCartUseCase(this.cartRepoContract);
  final CartRepoContract cartRepoContract;

  Future<BaseResponse<CartResponseEntity>> call() {
    return cartRepoContract.getCartItems();
  }
}
