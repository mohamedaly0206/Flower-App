import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/features/best_seller/domain/repo/best_seller_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class BestSellerUseCase {
  final BestSellerRepoContract _bestSellerRepoContract;

  BestSellerUseCase(this._bestSellerRepoContract);
  Future<BaseResponse<ProductsResponseEntity>> call() async {
    return await _bestSellerRepoContract.getBestSeller();
  }
}
