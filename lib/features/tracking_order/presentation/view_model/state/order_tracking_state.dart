part of '../cubit/order_tracking_cubit.dart';

class OrderTrackingState extends Equatable {
  final BaseState<TrackingOrderEntity>? trackOrderState;
  final BaseState<void>? completeOrderState;

  const OrderTrackingState({
    this.trackOrderState = const BaseState(),
    this.completeOrderState = const BaseState(),
  });

  OrderTrackingState copyWith({
    BaseState<TrackingOrderEntity>? trackOrderState,
    BaseState<void>? completeOrderState,
  }) {
    return OrderTrackingState(
      trackOrderState: trackOrderState ?? this.trackOrderState,
      completeOrderState: completeOrderState ?? this.completeOrderState,
    );
  }

  int get currentStep {
    final status = trackOrderState?.data?.status ?? '';
    switch (status) {
      case 'accepted':
        return 0;
      case 'picked':
        return 1;
      case 'outForDelivery':
        return 2;
      case 'arrived':
        return 3;
      case 'delivered':
      case 'completed':
        return 4;
      default:
        return 0;
    }
  }

  bool get isOrderCompleted => currentStep == 4;

  @override
  List<Object?> get props => [trackOrderState, completeOrderState];
}
