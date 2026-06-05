import 'dart:developer';

import 'package:flower_app/features/checkout/presentation/view_model/intent/checkout_intent.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState());

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
      case PlaceOrderIntent():
        // TODO: Handle this case.
        throw UnimplementedError();
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
}
