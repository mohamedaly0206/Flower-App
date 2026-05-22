import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/features/best_seller/domain/repo/best_seller_repo_contract.dart';
import 'package:flower_app/features/best_seller/domain/use_case/best_seller_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([BestSellerRepoContract])
import 'best_seller_use_case_test.mocks.dart';

void main() {
  late MockBestSellerRepoContract mockBestSellerRepoContract;
  late BestSellerUseCase useCase;

  setUp(() {
    mockBestSellerRepoContract = MockBestSellerRepoContract();
    useCase = BestSellerUseCase(mockBestSellerRepoContract);
  });

  group('BestSellerUseCase Tests', () {
    final tProductsResponseEntity = ProductsResponseEntity();

    test(
      'should get ProductsResponseEntity from the repository when the call is successful',
      () async {
        // Arrange
        when(mockBestSellerRepoContract.getBestSeller()).thenAnswer(
          (_) async => SuccessBaseResponse<ProductsResponseEntity>(
            data: tProductsResponseEntity,
          ),
        );

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<SuccessBaseResponse<ProductsResponseEntity>>());
        expect(
          (result as SuccessBaseResponse<ProductsResponseEntity>).data,
          tProductsResponseEntity,
        );

        verify(mockBestSellerRepoContract.getBestSeller()).called(1);
        verifyNoMoreInteractions(mockBestSellerRepoContract);
      },
    );

    test(
      'should return ErrorBaseResponse from the repository when the call fails',
      () async {
        // Arrange
        const tErrorMessage = 'Server Failure';
        when(mockBestSellerRepoContract.getBestSeller()).thenAnswer(
          (_) async => ErrorBaseResponse<ProductsResponseEntity>(
            errorMessage: tErrorMessage,
          ),
        );

        // Act
        final result = await useCase();

        // Assert
        expect(result, isA<ErrorBaseResponse<ProductsResponseEntity>>());
        expect(
          (result as ErrorBaseResponse<ProductsResponseEntity>).errorMessage,
          tErrorMessage,
        );

        verify(mockBestSellerRepoContract.getBestSeller()).called(1);
        verifyNoMoreInteractions(mockBestSellerRepoContract);
      },
    );
  });
}
