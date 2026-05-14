import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/best_seller/data/repo/best_seller_repo_impl.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_model.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBestSellerRemoteDataSource
    implements BestSellerRemoteDataSourceContract {
  int callsCount = 0;
  late BaseResponse<List<BestSellerDto>> response;

  @override
  Future<BaseResponse<List<BestSellerDto>>> getBestSeller() async {
    callsCount++;
    return response;
  }
}

void main() {
  group('BestSellerRepoImpl', () {
    test('maps dto list to domain model list on success', () async {
      final remoteDataSource = _FakeBestSellerRemoteDataSource()
        ..response = SuccessBaseResponse(
          data: [
            BestSellerDto(
              id: '1',
              title: 'Red Rose Bouquet',
              imgCover: 'https://example.com/rose.png',
              price: 300,
              priceAfterDiscount: 250,
              discount: 15,
            ),
          ],
        );
      final repository = BestSellerRepoImpl(remoteDataSource);

      final result = await repository.getBestSeller();

      expect(remoteDataSource.callsCount, 1);
      expect(result, isA<SuccessBaseResponse<List<BestSellerModel>>>());

      final data = (result as SuccessBaseResponse<List<BestSellerModel>>).data;
      expect(data, hasLength(1));
      expect(data.first.id, '1');
      expect(data.first.title, 'Red Rose Bouquet');
      expect(data.first.imgCover, 'https://example.com/rose.png');
      expect(data.first.price, 300);
      expect(data.first.priceAfterDiscount, 250);
      expect(data.first.discount, 15);
    });

    test('uses dto default values when nullable fields are missing', () async {
      final remoteDataSource = _FakeBestSellerRemoteDataSource()
        ..response = SuccessBaseResponse(data: [BestSellerDto()]);
      final repository = BestSellerRepoImpl(remoteDataSource);

      final result = await repository.getBestSeller();

      final data = (result as SuccessBaseResponse<List<BestSellerModel>>).data;
      expect(data.first.id, '');
      expect(data.first.title, '');
      expect(data.first.imgCover, '');
      expect(data.first.price, 0);
      expect(data.first.priceAfterDiscount, 0);
      expect(data.first.discount, 0);
    });

    test('returns error response with same error message on failure', () async {
      final remoteDataSource = _FakeBestSellerRemoteDataSource()
        ..response = ErrorBaseResponse(errorMessage: 'network error');
      final repository = BestSellerRepoImpl(remoteDataSource);

      final result = await repository.getBestSeller();

      expect(remoteDataSource.callsCount, 1);
      expect(result, isA<ErrorBaseResponse<List<BestSellerModel>>>());
      expect(
        (result as ErrorBaseResponse<List<BestSellerModel>>).errorMessage,
        'network error',
      );
    });
  });
}
