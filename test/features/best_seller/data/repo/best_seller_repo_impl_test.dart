import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/best_seller/data/repo/best_seller_repo_impl.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/core/shared_features/products/data/models/product_dto.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBestSellerRemoteDataSource
    implements BestSellerRemoteDataSourceContract {
  int callsCount = 0;
  late BaseResponse<BestSellerDto> response;

  @override
  Future<BaseResponse<BestSellerDto>> getBestSeller() async {
    callsCount++;
    return response;
  }
}

void main() {
  group('BestSellerRepoImpl', () {
    test('maps dto to domain model on success', () async {
      final remoteDataSource = _FakeBestSellerRemoteDataSource()
        ..response = SuccessBaseResponse(
          data: BestSellerDto(
            message: 'success',
            bestSeller: [
              ProductDTO(
                id: '1',
                title: 'Red Rose Bouquet',
                imgCover: 'https://example.com/rose.png',
                price: 300,
                priceAfterDiscount: 250,
                discount: 15,
              ),
            ],
          ),
        );
      final repository = BestSellerRepoImpl(remoteDataSource);

      final result = await repository.getBestSeller();

      expect(remoteDataSource.callsCount, 1);
      expect(result, isA<SuccessBaseResponse<ProductsResponseEntity>>());

      final data =
          (result as SuccessBaseResponse<ProductsResponseEntity>).data;
      expect(data.products, hasLength(1));
      expect(data.products!.first.id, '1');
      expect(data.products!.first.title, 'Red Rose Bouquet');
      expect(data.products!.first.imageCover, 'https://example.com/rose.png');
      expect(data.products!.first.price, 300);
      expect(data.products!.first.priceAfterDiscount, 250);
      expect(data.products!.first.discount, 15);
    });

    test('uses dto default values when nullable fields are missing', () async {
      final remoteDataSource = _FakeBestSellerRemoteDataSource()
        ..response = SuccessBaseResponse(
          data: BestSellerDto(bestSeller: [ProductDTO()]),
        );
      final repository = BestSellerRepoImpl(remoteDataSource);

      final result = await repository.getBestSeller();

      final data =
          (result as SuccessBaseResponse<ProductsResponseEntity>).data;
      expect(data.products, hasLength(1));
      expect(data.products!.first.id, isNull);
      expect(data.products!.first.title, isNull);
      expect(data.products!.first.imageCover, isNull);
      expect(data.products!.first.price, isNull);
      expect(data.products!.first.priceAfterDiscount, isNull);
      expect(data.products!.first.discount, isNull);
    });

    test('returns error response with same error message on failure', () async {
      final remoteDataSource = _FakeBestSellerRemoteDataSource()
        ..response = ErrorBaseResponse(errorMessage: 'network error');
      final repository = BestSellerRepoImpl(remoteDataSource);

      final result = await repository.getBestSeller();

      expect(remoteDataSource.callsCount, 1);
      expect(result, isA<ErrorBaseResponse<ProductsResponseEntity>>());
      expect(
        (result as ErrorBaseResponse<ProductsResponseEntity>).errorMessage,
        'network error',
      );
    });
  });
}
