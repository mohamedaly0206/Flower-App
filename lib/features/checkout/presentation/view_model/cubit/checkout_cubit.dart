import 'dart:developer';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/domain/entities/response/checkout_response_entity.dart';
import 'package:flower_app/features/checkout/domain/use_cases/checkout_cash_use_case.dart';
import 'package:flower_app/features/checkout/presentation/view_model/intent/checkout_intent.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutCashUseCase _checkoutCashUseCase;
  CheckoutCubit(CheckoutCashUseCase checkoutCashUseCase)
    : _checkoutCashUseCase = checkoutCashUseCase,
      super(const CheckoutState());

  void handleCheckoutIntent(CheckoutIntent intent) {
    switch (intent) {
      case SelectDeliveryAddressIntent():
        _selectAddress(intent.addressId);
        break;
      case SelectPaymentMethodIntent():
        _selectPaymentMethod(intent.paymentMethod);
        break;
      case SelectIsItGiftIntent():
        _selectIsItGift(intent.isGift);
        break;
      case PlaceCashOrderIntent():
        _placeCashOrder(intent.checkoutRequest);
        break;
      case PlaceCreditCardOrderIntent():
        _placeCreditCardOrder();
        break;
    }
  }

  void _selectAddress(String addressId) {
    emit(state.copyWith(selectedAddressId: addressId));
    log('Selected Address ID: $addressId');
  }

  void _selectPaymentMethod(PaymentMethod paymentMethod) {
    if (state.isGift && paymentMethod == PaymentMethod.cashOnDelivery) {
      return;
    }
    emit(state.copyWith(selectedPaymentMethod: paymentMethod));
    log('Selected Payment Method: $paymentMethod');
  }

  void _selectIsItGift(bool isGift) {
    emit(state.copyWith(isGift: isGift = !state.isGift));
    if (isGift) {
      emit(state.copyWith(selectedPaymentMethod: PaymentMethod.creditCard));
    } else {
      emit(state.copyWith(selectedPaymentMethod: PaymentMethod.cashOnDelivery));
    }
    log('Is it a gift? $isGift');
    log(
      'Selected Payment Method after gift selection: ${state.selectedPaymentMethod}',
    );
  }

  Future<void> _placeCashOrder(CheckoutRequest checkoutRequest) async {
    emit(
      state.copyWith(
        checkoutCashState: state.checkoutCashState.copyWith(
          isLoadingParam: true,
          dataParam: null,
          errorMessageParam: null,
        ),
      ),
    );
    final response = await _checkoutCashUseCase.call(checkoutRequest);
    switch (response) {
      case SuccessBaseResponse<CheckoutResponseEntity>():
        emit(
          state.copyWith(
            checkoutCashState: state.checkoutCashState.copyWith(
              dataParam: response.data,
              isLoadingParam: false,
              errorMessageParam: null,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<CheckoutResponseEntity>():
        emit(
          state.copyWith(
            checkoutCashState: state.checkoutCashState.copyWith(
              errorMessageParam: response.errorMessage,
              isLoadingParam: false,
              dataParam: null,
            ),
          ),
        );
        break;
    }
  }
}

void _placeCreditCardOrder() {
  // TODO: Handle this case.
  throw UnimplementedError();
}
