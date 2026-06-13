import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';
import 'package:flower_app/features/orders/domain/repo/orders_repo_contract.dart';
import 'package:flower_app/features/orders/domain/use_case/orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrdersRepoContract])
import 'orders_use_case_test.mocks.dart';

void main() {
  late MockOrdersRepoContract mockOrdersRepoContract;
  late OrdersRepoUseCase ordersRepoUseCase;

  setUp(() {
    mockOrdersRepoContract = MockOrdersRepoContract();
    ordersRepoUseCase = OrdersRepoUseCase(mockOrdersRepoContract);

    provideDummy<BaseResponse<List<OrdersModel>>>(
      SuccessBaseResponse(data: []),
    );
  });

  group('OrdersRepoUseCase Tests', () {
    test(
      'should return SuccessBaseResponse when ordersRepoContract returns data successfully',
      () async {
        // Arrange
        final mockOrdersList = [
          OrdersModel(
            id: '1',
            orderNumber: 'ORD-999',
            totalPrice: 200,
            isDelivered: true,
            state: 'Delivered',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isPaid: true,
          ),
        ];

        final mockResponse = SuccessBaseResponse<List<OrdersModel>>(
          data: mockOrdersList,
        );

        when(
          mockOrdersRepoContract.getUserOrders(),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await ordersRepoUseCase.call();

        // Assert
        expect(result, isA<SuccessBaseResponse<List<OrdersModel>>>());
        expect(
          (result as SuccessBaseResponse<List<OrdersModel>>).data.length,
          1,
        );
        expect(result.data[0].orderNumber, 'ORD-999');
        verify(mockOrdersRepoContract.getUserOrders()).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse when ordersRepoContract fails',
      () async {
        // Arrange
        final mockErrorResponse = ErrorBaseResponse<List<OrdersModel>>(
          errorMessage: 'Failed to fetch orders from repository',
        );

        when(
          mockOrdersRepoContract.getUserOrders(),
        ).thenAnswer((_) async => mockErrorResponse);

        // Act
        final result = await ordersRepoUseCase.call();

        // Assert
        expect(result, isA<ErrorBaseResponse<List<OrdersModel>>>());
        expect(
          (result as ErrorBaseResponse).errorMessage,
          'Failed to fetch orders from repository',
        );
        verify(mockOrdersRepoContract.getUserOrders()).called(1);
      },
    );
  });
}
