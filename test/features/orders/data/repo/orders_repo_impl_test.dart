import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/data/data_sources/orders_remote_data_source_contract.dart';
import 'package:flower_app/features/orders/data/models/orders.dart';
import 'package:flower_app/features/orders/data/models/orders_response_dto.dart';
import 'package:flower_app/features/orders/data/repo/orders_repo_impl.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrdersRemoteDataSource, OrdersResponseDto, Orders])
import 'orders_repo_impl_test.mocks.dart';

void main() {
  late MockOrdersRemoteDataSource mockRemoteDataSource;
  late OrdersRepoImpl ordersRepo;

  setUp(() {
    mockRemoteDataSource = MockOrdersRemoteDataSource();
    ordersRepo = OrdersRepoImpl(mockRemoteDataSource);

    provideDummy<BaseResponse<List<OrdersModel>>>(
      SuccessBaseResponse(data: []),
    );
  });

  group('OrdersRepoImpl - getUserOrders Tests', () {
    test(
      'should return SuccessBaseResponse with Domain Models when remote data source returns DTO successfully',
      () async {
        // Arrange

        final mockOrderDto = MockOrders();
        final mockOrdersModel = OrdersModel(
          id: '1',
          orderNumber: 'ORD-1234',
          totalPrice: 150,
          isDelivered: false,
          state: 'Pending',
          createdAt: DateTime.parse('2026-06-08'),
          updatedAt: DateTime.parse('2026-06-08'),
          isPaid: false,
        );

        when(mockOrderDto.toDomain()).thenReturn(mockOrdersModel);

        final mockResponseDto = OrdersResponseDto(orders: [mockOrderDto]);

        when(
          mockRemoteDataSource.getUserOrders(),
        ).thenAnswer((_) async => mockResponseDto);

        // Act
        final result = await ordersRepo.getUserOrders();

        // Assert
        expect(result, isA<SuccessBaseResponse<List<OrdersModel>>>());
        expect(
          (result as SuccessBaseResponse<List<OrdersModel>>).data.length,
          1,
        );
        expect(result.data[0], equals(mockOrdersModel));
        verify(mockRemoteDataSource.getUserOrders()).called(1);
      },
    );

    test(
      'should return SuccessBaseResponse with empty list when remote response orders is null',
      () async {
        // Arrange
        final mockResponseDto = OrdersResponseDto(orders: null);

        when(
          mockRemoteDataSource.getUserOrders(),
        ).thenAnswer((_) async => mockResponseDto);

        // Act
        final result = await ordersRepo.getUserOrders();

        // Assert
        expect(result, isA<SuccessBaseResponse<List<OrdersModel>>>());
        expect(
          (result as SuccessBaseResponse<List<OrdersModel>>).data,
          isEmpty,
        );
        verify(mockRemoteDataSource.getUserOrders()).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse with exception string when remote data source throws an error',
      () async {
        // Arrange
        final exception = Exception('Connection Failed');
        when(mockRemoteDataSource.getUserOrders()).thenThrow(exception);

        // Act
        final result = await ordersRepo.getUserOrders();

        // Assert
        expect(result, isA<ErrorBaseResponse<List<OrdersModel>>>());

        expect(
          (result as ErrorBaseResponse).errorMessage,
          exception.toString(),
        );
        verify(mockRemoteDataSource.getUserOrders()).called(1);
      },
    );
  });
}
