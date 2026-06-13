import 'package:flower_app/features/orders/api/api_client/orders_api_client.dart';
import 'package:flower_app/features/orders/api/data_sources/orders_remote_data_source_impl.dart';
import 'package:flower_app/features/orders/data/models/orders_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OrdersApiClient])
void main() {
  late MockOrdersApiClient mockOrdersApiClient;
  late OrdersRemoteDataSourceImpl ordersRemoteDataSource;

  setUp(() {
    mockOrdersApiClient = MockOrdersApiClient();
    ordersRemoteDataSource = OrdersRemoteDataSourceImpl(mockOrdersApiClient);
  });

  group('OrdersRemoteDataSourceImpl - getUserOrders Tests', () {
    test(
      'should return OrdersResponseDto when ordersApiClient returns data successfully',
      () async {
        // Arrange

        final mockOrdersResponse = OrdersResponseDto();

        when(
          mockOrdersApiClient.getUserOrders(),
        ).thenAnswer((_) async => mockOrdersResponse);

        // Act
        final result = await ordersRemoteDataSource.getUserOrders();

        // Assert
        expect(result, isA<OrdersResponseDto>());
        expect(result, equals(mockOrdersResponse));
        verify(mockOrdersApiClient.getUserOrders()).called(1);
      },
    );

    test('should throw an exception when ordersApiClient fails', () async {
      // Arrange
      final expectedException = Exception('Server Error');
      when(mockOrdersApiClient.getUserOrders()).thenThrow(expectedException);

      // Act & Assert
      expect(
        () async => await ordersRemoteDataSource.getUserOrders(),
        throwsA(equals(expectedException)),
      );
      verify(mockOrdersApiClient.getUserOrders()).called(1);
    });
  });
}
