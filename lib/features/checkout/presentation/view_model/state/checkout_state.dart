import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';

enum PaymentMethod { cashOnDelivery, creditCard }

class CheckoutState extends Equatable {
  final BaseState checkoutCashState;
  final String? selectedAddressId;
  final PaymentMethod? selectedPaymentMethod;
  final bool isGift;

  const CheckoutState({
    this.selectedAddressId , // Defaulting to home
    this.selectedPaymentMethod,
    this.isGift = false,
    this.checkoutCashState = const BaseState(),
  });

  CheckoutState copyWith({
    String? selectedAddressId,
    PaymentMethod? selectedPaymentMethod,
    bool? isGift,
    BaseState? checkoutCashState,
  }) {
    return CheckoutState(
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isGift: isGift ?? this.isGift,
      checkoutCashState: checkoutCashState ?? this.checkoutCashState,
    );
  }

  @override
  List<Object?> get props => [
    selectedAddressId,
    selectedPaymentMethod,
    isGift,
    checkoutCashState,
  ];
}
