import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/router/app_router.dart';
import 'package:flower_app/features/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:flower_app/features/best_seller/api/data_sources/best_seller_remote_data_source_impl.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/core/shared_features/products/data/models/product_dto.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeBestSellerApiClient implements BestSellerApiClient {
  BestSellerDto? response;
  Object? error;
  int callsCount = 0;

  @override
  Future<BestSellerDto> getBestSellers() async {
    callsCount++;
    final error = this.error;
    if (error != null) throw error;
    return response!;
  }
}

// Helper: pumps a minimal app so navigatorKey.currentContext is available
// for ServerFailure.failureHandler (which reads localized strings via context).
Future<void> _pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SizedBox(),
    ),
  );
}

void main() {
  group('BestSellerRemoteDataSourceImpl', () {
    // -------------------------------------------------------------------------
    // Success path — happy path, no Flutter binding needed
    // -------------------------------------------------------------------------
    test('returns success response with best seller dto', () async {
      final bestSellers = [
        ProductDTO(
          id: '1',
          title: 'Red Rose Bouquet',
          imgCover: 'https://example.com/rose.png',
          price: 300,
          priceAfterDiscount: 250,
          discount: 15,
        ),
      ];
      final apiClient = _FakeBestSellerApiClient()
        ..response = BestSellerDto(message: 'success', bestSeller: bestSellers);
      final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

      final result = await dataSource.getBestSeller();

      expect(apiClient.callsCount, 1);
      expect(result, isA<SuccessBaseResponse<BestSellerDto>>());
      final data = (result as SuccessBaseResponse<BestSellerDto>).data;
      expect(data.bestSeller, bestSellers);
    });

    test('returns success when response bestSeller is null', () async {
      final apiClient = _FakeBestSellerApiClient()
        ..response = BestSellerDto();
      final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

      final result = await dataSource.getBestSeller();

      expect(result, isA<SuccessBaseResponse<BestSellerDto>>());
      final data = (result as SuccessBaseResponse<BestSellerDto>).data;
      expect(data.bestSeller, isNull);
    });

    // -------------------------------------------------------------------------
    // Failure paths — ServerFailure.failureHandler reads navigatorKey.currentContext
    // so we must pump a real MaterialApp first to make the context available.
    // -------------------------------------------------------------------------
    testWidgets(
      'returns error response when api client throws DioException',
      (tester) async {
        await _pumpApp(tester);

        final apiClient = _FakeBestSellerApiClient()
          ..error = DioException(
            requestOptions: RequestOptions(path: '/best-seller'),
            message: 'network error',
          );
        final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

        final result = await dataSource.getBestSeller();

        expect(result, isA<ErrorBaseResponse<BestSellerDto>>());
      },
    );

    testWidgets(
      'returns error response when api client throws TimeoutException',
      (tester) async {
        await _pumpApp(tester);

        final apiClient = _FakeBestSellerApiClient()
          ..error = TimeoutException('request timed out');
        final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

        final result = await dataSource.getBestSeller();

        expect(result, isA<ErrorBaseResponse<BestSellerDto>>());
      },
    );

    testWidgets(
      'returns error response when api client throws unknown error',
      (tester) async {
        await _pumpApp(tester);

        final apiClient = _FakeBestSellerApiClient()
          ..error = Exception('unknown error');
        final dataSource = BestSellerRemoteDataSourceImpl(apiClient);

        final result = await dataSource.getBestSeller();

        expect(result, isA<ErrorBaseResponse<BestSellerDto>>());
      },
    );
  });
}
