import 'package:equatable/equatable.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';

enum OrdersStatus { initial, loading, success, error }

class OrdersState extends Equatable {
  final OrdersStatus status;
  final List<OrdersModel> allOrders;
  final List<OrdersModel> activeOrders;
  final List<OrdersModel> completedOrders;
  final String? errorMessage;

  const OrdersState({
    this.status = OrdersStatus.initial,
    this.allOrders = const [],
    this.activeOrders = const [],
    this.completedOrders = const [],
    this.errorMessage,
  });

  OrdersState copyWith({
    OrdersStatus? status,
    List<OrdersModel>? allOrders,
    List<OrdersModel>? activeOrders,
    List<OrdersModel>? completedOrders,
    String? errorMessage,
  }) {
    return OrdersState(
      status: status ?? this.status,
      allOrders: allOrders ?? this.allOrders,
      activeOrders: activeOrders ?? this.activeOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allOrders,
    activeOrders,
    completedOrders,
    errorMessage,
  ];
}
