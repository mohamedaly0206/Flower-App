import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/repositories/cart_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddItemToCartUseCase {
  final CartRepoContract cartRepoContract;
  AddItemToCartUseCase(this.cartRepoContract);
  Future<BaseResponse<CartResponseEntity>> call(AddToCartRequest request) {
    return cartRepoContract.addItemToCart(request);
  }
}
