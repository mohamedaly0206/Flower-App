import 'package:flower_app/features/checkout/domain/entities/request/shipping_address_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_dto.g.dart';

@JsonSerializable()
class ShippingAddress {
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;

  ShippingAddress({this.street, this.phone, this.city, this.lat, this.long});

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
  ShippingAddressEntity toDomain() {
    return ShippingAddressEntity(
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
    );
  }
}
