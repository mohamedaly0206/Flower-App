import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';

sealed class CheckoutIntent {}

class PlaceOrderIntent extends CheckoutIntent {}

class SelectPaymentMethodIntent extends CheckoutIntent {
  final PaymentMethod paymentMethod;
  SelectPaymentMethodIntent({required this.paymentMethod});
}

class SelectDeliveryAddressIntent extends CheckoutIntent {
  final String addressId;
  SelectDeliveryAddressIntent({required this.addressId});
}

class SelectIsItGiftIntent extends CheckoutIntent {
  final bool isGift;
  SelectIsItGiftIntent({required this.isGift});
}
