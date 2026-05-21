import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/features/best_seller/domain/repo/best_seller_repo_contract.dart';
import 'package:flower_app/features/best_seller/domain/use_case/best_seller_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBestSellerRepo implements BestSellerRepoContract {
  int callsCount = 0;
  late BaseResponse<ProductsResponseEntity> response;

  @override
  Future<BaseResponse<ProductsResponseEntity>> getBestSeller() async {
    callsCount++;
    return response;
  }
}

void main() {
  group('BestSellerUseCase', () {
    test('forwards getBestSeller call to repository', () async {
      final products = [
        ProductEntity(
          id: '1',
          title: 'Red Rose Bouquet',
          imageCover: 'https://example.com/rose.png',
          price: 300,
          priceAfterDiscount: 250,
          discount: 15,
        ),
      ];
      final repository = _FakeBestSellerRepo()
        ..response = SuccessBaseResponse(
          data: ProductsResponseEntity(
            message: 'success',
            products: products,
          ),
        );
      final useCase = BestSellerUseCase(repository);

      final result = await useCase();

      expect(result, same(repository.response));
      expect(repository.callsCount, 1);
    });
  });
}
