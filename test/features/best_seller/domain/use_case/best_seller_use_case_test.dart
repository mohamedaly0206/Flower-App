import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_entity.dart';
import 'package:flower_app/features/best_seller/domain/repo/best_seller_repo_contract.dart';
import 'package:flower_app/features/best_seller/domain/use_case/best_seller_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBestSellerRepo implements BestSellerRepoContract {
  int callsCount = 0;
  late BaseResponse<List<BestSellerEntity>> response;

  @override
  Future<BaseResponse<List<BestSellerEntity>>> getBestSeller() async {
    callsCount++;
    return response;
  }
}

void main() {
  group('BestSellerUseCase', () {
    test('forwards getBestSeller call to repository', () async {
      final bestSellers = [
        BestSellerEntity(
          id: '1',
          title: 'Red Rose Bouquet',
          imgCover: 'https://example.com/rose.png',
          price: 300,
          priceAfterDiscount: 250,
          discount: 15,
        ),
      ];
      final repository = _FakeBestSellerRepo()
        ..response = SuccessBaseResponse(data: bestSellers);
      final useCase = BestSellerUseCase(repository);

      final result = await useCase();

      expect(result, same(repository.response));
      expect(repository.callsCount, 1);
    });
  });
}
