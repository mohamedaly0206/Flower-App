import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/data/models/products_response.dart';
import 'package:flower_app/core/shared_features/domain/repo/products_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final ProductsRepository _productsRepository;

  GetProductsUseCase(this._productsRepository);

  Future<BaseResponse<ProductsResponse>> call({
    String? categoryId,
    String? occasionId,
  }) {
    return _productsRepository.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
    );
  }
}
