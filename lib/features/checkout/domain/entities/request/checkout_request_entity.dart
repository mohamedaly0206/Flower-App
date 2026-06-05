import 'package:equatable/equatable.dart';
import 'package:flower_app/features/checkout/domain/entities/request/shipping_address_entity.dart';

class CheckoutRequestEntity extends Equatable {
final ShippingAddressEntity? shippingAddress;

  const CheckoutRequestEntity({
   required this.shippingAddress,
  });

  @override
  List<Object?> get props => [shippingAddress];
}