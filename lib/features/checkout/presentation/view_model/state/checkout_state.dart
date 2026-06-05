import 'package:equatable/equatable.dart';

enum PaymentMethod { cashOnDelivery, creditCard }

class CheckoutState extends Equatable {
  final String selectedAddressId;
  final PaymentMethod? selectedPaymentMethod;
  final bool isGift;

  const CheckoutState({
    this.selectedAddressId = 'home', // Defaulting to home
    this.selectedPaymentMethod, 
    this.isGift = false,
  });

  CheckoutState copyWith({
    String? selectedAddressId,
    PaymentMethod? selectedPaymentMethod,
    bool? isGift,
  }) {
    return CheckoutState(
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
      selectedPaymentMethod:
          selectedPaymentMethod ?? this.selectedPaymentMethod,
      isGift: isGift ?? this.isGift,
    );
  }

  @override
  List<Object?> get props => [selectedAddressId, selectedPaymentMethod, isGift];
}
