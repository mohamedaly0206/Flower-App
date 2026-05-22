import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:flower_app/features/best_seller/api/data_sources/best_seller_remote_data_source_impl.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([BestSellerApiClient])
import 'best_seller_remote_data_source_impl_test.mocks.dart';

void main() {
  late MockBestSellerApiClient mockApiClient;
  late BestSellerRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockApiClient = MockBestSellerApiClient();
    remoteDataSource = BestSellerRemoteDataSourceImpl(mockApiClient);
  });

  group('getBestSeller Remote Data Source Tests', () {
    final tBestSellerDto = BestSellerDto(bestSeller: []);

    test(
      'should return SuccessBaseResponse when the call to API client is successful',
      () async {
        when(
          mockApiClient.getBestSellers(),
        ).thenAnswer((_) async => tBestSellerDto);

        final result = await remoteDataSource.getBestSeller();

        expect(result, isA<SuccessBaseResponse<BestSellerDto>>());
        expect(
          (result as SuccessBaseResponse<BestSellerDto>).data,
          tBestSellerDto,
        );
        verify(mockApiClient.getBestSellers()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorBaseResponse when the call to API client throws an exception',
      () async {
        final tException = Exception('Server Error');
        when(mockApiClient.getBestSellers()).thenThrow(tException);

        // Act
        final result = await remoteDataSource.getBestSeller();

        // Assert
        expect(result, isA<ErrorBaseResponse<BestSellerDto>>());

        expect(
          (result as ErrorBaseResponse<BestSellerDto>).errorMessage,
          isNotNull,
        );
        verify(mockApiClient.getBestSellers()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });
}
