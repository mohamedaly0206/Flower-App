import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';
import 'package:flower_app/features/orders/domain/use_case/orders_use_case.dart';
import 'package:flower_app/features/orders/presentation/view_model/cubit/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/view_model/intent/orders_intent.dart';
import 'package:flower_app/features/orders/presentation/view_model/state/orders_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrdersRepoUseCase])
import 'orders_cubit_test.mocks.dart';

void main() {
  late MockOrdersRepoUseCase mockGetOrdersUseCase;
  late OrdersCubit ordersCubit;

  setUp(() {
    mockGetOrdersUseCase = MockOrdersRepoUseCase();
    ordersCubit = OrdersCubit(mockGetOrdersUseCase);
    provideDummy<BaseResponse<List<OrdersModel>>>(
      SuccessBaseResponse(data: []),
    );
  });

  tearDown(() {
    ordersCubit.close();
  });

  group('OrdersCubit - MVI Tests', () {
    final activeOrder = OrdersModel(
      id: '1',
      orderNumber: 'ORD-ACTIVE',
      totalPrice: 100,
      isDelivered: false,
      state: 'Pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isPaid: true,
    );

    final completedOrder = OrdersModel(
      id: '2',
      orderNumber: 'ORD-COMPLETED',
      totalPrice: 200,
      isDelivered: true,
      state: 'Delivered',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isPaid: true,
    );

    final mockOrdersList = [activeOrder, completedOrder];

    blocTest<OrdersCubit, OrdersState>(
      'emits [loading, success] with filtered active and completed orders when FetchOrdersIntent is successful',
      build: () {
        when(mockGetOrdersUseCase.call()).thenAnswer(
          (_) async =>
              SuccessBaseResponse<List<OrdersModel>>(data: mockOrdersList),
        );
        return ordersCubit;
      },
      act: (cubit) => cubit.handleIntent(FetchOrdersIntent()),
      expect: () => [
        OrdersState(status: OrdersStatus.loading),

        OrdersState(
          status: OrdersStatus.success,
          allOrders: mockOrdersList,
          activeOrders: [activeOrder],
          completedOrders: [completedOrder],
        ),
      ],
      verify: (_) {
        verify(mockGetOrdersUseCase.call()).called(1);
      },
    );

    blocTest<OrdersCubit, OrdersState>(
      'emits [loading, error] with errorMessage when FetchOrdersIntent fails',
      build: () {
        when(mockGetOrdersUseCase.call()).thenAnswer(
          (_) async => ErrorBaseResponse<List<OrdersModel>>(
            errorMessage: 'Server Error 500',
          ),
        );
        return ordersCubit;
      },
      act: (cubit) => cubit.handleIntent(FetchOrdersIntent()),
      expect: () => [
        OrdersState(status: OrdersStatus.loading),
        OrdersState(
          status: OrdersStatus.error,
          errorMessage: 'Server Error 500',
        ),
      ],
      verify: (_) {
        verify(mockGetOrdersUseCase.call()).called(1);
      },
    );
  });
}
