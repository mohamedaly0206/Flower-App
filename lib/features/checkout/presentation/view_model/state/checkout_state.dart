import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';

enum PaymentMethod { cashOnDelivery, creditCard }

class CheckoutState extends Equatable {
  final BaseState checkoutCashState;
  final BaseState checkoutCreditState;
  final String? selectedAddressId;
  final PaymentMethod? selectedPaymentMethod;
  final bool isGift;

  const CheckoutState({
    this.checkoutCreditState = const BaseState(),
    this.selectedAddressId,
    this.selectedPaymentMethod,
    this.isGift = false,
    this.checkoutCashState = const BaseState(),
  });

  CheckoutState copyWith({
    String? selectedAddressId,
    PaymentMethod? selectedPaymentMethod,
    bool? isGift,
    BaseState? checkoutCashState,
    BaseState? checkoutCreditState,
  }) {
    return CheckoutState(
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isGift: isGift ?? this.isGift,
      checkoutCashState: checkoutCashState ?? this.checkoutCashState,
      checkoutCreditState: checkoutCreditState ?? this.checkoutCreditState,
    );
  }

  @override
  List<Object?> get props => [
    selectedAddressId,
    selectedPaymentMethod,
    isGift,
    checkoutCashState,
    checkoutCreditState,
  ];
}
