import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/core/shared_features/products/domain/repositories/products_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final ProductsRepoContract _productsRepository;

  GetProductsUseCase(this._productsRepository);

  Future<BaseResponse<ProductsResponseEntity>> call({
    String? categoryId,
    String? occasionId,
    String? search,
  }) {
    return _productsRepository.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
      search: search,
    );
  }
}
