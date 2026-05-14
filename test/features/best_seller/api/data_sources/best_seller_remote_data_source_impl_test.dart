import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:flower_app/features/best_seller/api/data_sources/best_seller_remote_data_source_impl.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/best_seller/data/models/response/best_seller_response.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBestSellerApiClient implements BestSellerApiClient {
  BestSellerResponse? response;
  Object? error;
  int callsCount = 0;

  @override
  Future<BestSellerResponse> getBestSellers() async {
    callsCount++;

    final error = this.error;
    if (error != null) {
      throw error;
    }

    return response!;
  }
}

void main() {
  group('BestSellerRemoteDataSourceImpl', () {
    test('returns success response with best seller list', () async {
      final bestSellers = [
        BestSellerDto(
          id: '1',
          title: 'Red Rose Bouquet',
          imgCover: 'https://example.com/rose.png',
          price: 300,
          priceAfterDiscount: 250,
          discount: 15,
        ),
      ];
      final apiClient = _FakeBestSellerApiClient()
        ..response = BestSellerResponse(bestSellerDto: bestSellers);
      final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

      final result = await dataSource.getBestSeller();

      expect(apiClient.callsCount, 1);
      expect(result, isA<SuccessBaseResponse<List<BestSellerDto>>>());
      expect(
        (result as SuccessBaseResponse<List<BestSellerDto>>).data,
        bestSellers,
      );
    });

    test('returns empty list when response bestSeller is null', () async {
      final apiClient = _FakeBestSellerApiClient()
        ..response = BestSellerResponse();
      final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

      final result = await dataSource.getBestSeller();

      expect(result, isA<SuccessBaseResponse<List<BestSellerDto>>>());
      expect((result as SuccessBaseResponse<List<BestSellerDto>>).data, []);
    });

    test(
      'returns Dio error message when api client throws DioException',
      () async {
        final apiClient = _FakeBestSellerApiClient()
          ..error = DioException(
            requestOptions: RequestOptions(path: '/best-seller'),
            message: 'network error',
          );
        final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

        final result = await dataSource.getBestSeller();

        expect(result, isA<ErrorBaseResponse<List<BestSellerDto>>>());
        expect(
          (result as ErrorBaseResponse<List<BestSellerDto>>).errorMessage,
          'network error',
        );
      },
    );

    test(
      'returns timeout message when api client throws TimeoutException',
      () async {
        final apiClient = _FakeBestSellerApiClient()
          ..error = TimeoutException('request timed out');
        final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

        final result = await dataSource.getBestSeller();

        expect(result, isA<ErrorBaseResponse<List<BestSellerDto>>>());
        expect(
          (result as ErrorBaseResponse<List<BestSellerDto>>).errorMessage,
          'request timed out',
        );
      },
    );

    test(
      'returns generic error message when api client throws unknown error',
      () async {
        final apiClient = _FakeBestSellerApiClient()
          ..error = Exception('unknown error');
        final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

        final result = await dataSource.getBestSeller();

        expect(result, isA<ErrorBaseResponse<List<BestSellerDto>>>());
        expect(
          (result as ErrorBaseResponse<List<BestSellerDto>>).errorMessage,
          'Something went wrong ,Please try again later',
        );
      },
    );
  });
}
