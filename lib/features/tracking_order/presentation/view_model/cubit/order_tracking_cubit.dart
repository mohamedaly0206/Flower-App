import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/tracking_order/domain/entities/tracking_order_entity.dart';
import 'package:flower_app/features/tracking_order/domain/usecases/complete_order_use_case.dart';
import 'package:flower_app/features/tracking_order/domain/usecases/track_order_use_case.dart';
import 'package:flower_app/features/tracking_order/presentation/view_model/intent/order_tracking_intent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part '../state/order_tracking_state.dart';

@injectable
class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  final TrackOrderUseCase _trackOrderUseCase;
  final CompleteOrderUseCase _completeOrderUseCase;
  StreamSubscription? _subscription;

  OrderTrackingCubit(this._trackOrderUseCase, this._completeOrderUseCase)
    : super(const OrderTrackingState());

  void doIntent(OrderTrackingIntent intent) {
    switch (intent) {
      case ListenToOrderIntent():
        _listenToOrder(intent.orderId);
      case MarkOrderCompletedIntent():
        _markOrderCompleted(intent.orderId);
    }
  }

  void _listenToOrder(String orderId) {
    emit(state.copyWith(trackOrderState: const BaseState(isLoading: true)));

    _subscription?.cancel();
    _subscription = _trackOrderUseCase(orderId).listen(
      (response) {
        if (response is SuccessBaseResponse<TrackingOrderEntity>) {
          emit(state.copyWith(trackOrderState: BaseState(data: response.data,)));
        } else if (response is ErrorBaseResponse<TrackingOrderEntity>) {
          emit(
            state.copyWith(
              trackOrderState: BaseState(errorMessage: response.errorMessage),
            ),
          );
        }
      },
      onError: (error) {
        emit(
          state.copyWith(
            trackOrderState: BaseState(errorMessage: error.toString()),
          ),
        );
      },
    );
  }

  Future<void> _markOrderCompleted(String orderId) async {
    emit(state.copyWith(completeOrderState: const BaseState(isLoading: true)));

    final response = await _completeOrderUseCase(orderId);

    if (response is SuccessBaseResponse<void>) {
      emit(state.copyWith(completeOrderState: const BaseState(data: null)));
    } else if (response is ErrorBaseResponse<void>) {
      emit(
        state.copyWith(
          completeOrderState: BaseState(errorMessage: response.errorMessage),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
