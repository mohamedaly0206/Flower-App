import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/domain/use_case/orders_use_case.dart';
import 'package:flower_app/features/orders/presentation/view_model/state/orders_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../intent/orders_intent.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepoUseCase _getOrdersUseCase;

  OrdersCubit(this._getOrdersUseCase) : super(const OrdersState());

  void handleIntent(OrdersIntent intent) {
    if (intent is FetchOrdersIntent) {
      _fetchOrders();
    }
  }

  Future<void> _fetchOrders() async {
    emit(state.copyWith(status: OrdersStatus.loading));

    final response = await _getOrdersUseCase();

    switch (response) {
      case SuccessBaseResponse():
        final ordersList = response.data;

        final active = ordersList
            .where((order) => order.isDelivered == false)
            .toList();
        final completed = ordersList
            .where((order) => order.isDelivered == true)
            .toList();

        emit(
          state.copyWith(
            status: OrdersStatus.success,
            allOrders: ordersList,
            activeOrders: active,
            completedOrders: completed,
          ),
        );

      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: OrdersStatus.error,
            errorMessage: response.errorMessage,
          ),
        );
    }
  }
}
