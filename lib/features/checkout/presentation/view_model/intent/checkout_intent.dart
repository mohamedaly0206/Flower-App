import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';

sealed class CheckoutIntent {}

class PlaceCashOrderIntent extends CheckoutIntent {
  final CheckoutRequest checkoutRequest;
  PlaceCashOrderIntent({required this.checkoutRequest});
}

class PlaceCreditCardOrderIntent extends CheckoutIntent {
  final CheckoutRequest checkoutRequest;
  PlaceCreditCardOrderIntent({required this.checkoutRequest});
}

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
