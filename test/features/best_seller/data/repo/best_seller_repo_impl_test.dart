import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/features/best_seller/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/best_seller/data/repo/best_seller_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([BestSellerRemoteDataSourceContract])
import 'best_seller_repo_impl_test.mocks.dart';

void main() {
  late MockBestSellerRemoteDataSourceContract mockRemoteDataSource;
  late BestSellerRepoImpl repository;

  setUpAll(() {
    provideDummy<BaseResponse<BestSellerDto>>(
      SuccessBaseResponse<BestSellerDto>(data: BestSellerDto(bestSeller: [])),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockBestSellerRemoteDataSourceContract();
    repository = BestSellerRepoImpl(mockRemoteDataSource);
  });

  group('getBestSeller Repository Tests', () {
    final tBestSellerDto = BestSellerDto(bestSeller: []);
    final tProductsResponseEntity = ProductsResponseEntity();

    test(
      'should return SuccessBaseResponse with Domain Entity when Remote Data Source succeeds',
      () async {
        when(mockRemoteDataSource.getBestSeller()).thenAnswer(
          (_) async => SuccessBaseResponse<BestSellerDto>(data: tBestSellerDto),
        );

        // Act
        final result = await repository.getBestSeller();

        // Assert
        expect(result, isA<SuccessBaseResponse<ProductsResponseEntity>>());
        expect(
          (result as SuccessBaseResponse<ProductsResponseEntity>).data,
          isA<ProductsResponseEntity>(),
        );

        verify(mockRemoteDataSource.getBestSeller()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return ErrorBaseResponse with same error message when Remote Data Source fails',
      () async {
        // Arrange
        const tErrorMessage = 'No Internet Connection';
        when(mockRemoteDataSource.getBestSeller()).thenAnswer(
          (_) async =>
              ErrorBaseResponse<BestSellerDto>(errorMessage: tErrorMessage),
        );

        // Act
        final result = await repository.getBestSeller();

        // Assert
        expect(result, isA<ErrorBaseResponse<ProductsResponseEntity>>());
        expect(
          (result as ErrorBaseResponse<ProductsResponseEntity>).errorMessage,
          tErrorMessage,
        );

        verify(mockRemoteDataSource.getBestSeller()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}
