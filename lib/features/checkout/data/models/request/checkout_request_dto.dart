
import 'package:flower_app/features/checkout/data/models/request/shipping_address_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/request/checkout_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'checkout_request_dto.g.dart';

CheckoutRequestDto checkoutRequestDtoFromJson(String str) => CheckoutRequestDto.fromJson(json.decode(str));

String checkoutRequestDtoToJson(CheckoutRequestDto data) => json.encode(data.toJson());

@JsonSerializable()
class CheckoutRequestDto {
    @JsonKey(name: "shippingAddress")
    final ShippingAddress? shippingAddress;

    CheckoutRequestDto({
        this.shippingAddress,
    });

    factory CheckoutRequestDto.fromJson(Map<String, dynamic> json) => _$CheckoutRequestDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CheckoutRequestDtoToJson(this);
    CheckoutRequestEntity toDomain() {
      return CheckoutRequestEntity(
        shippingAddress: shippingAddress?.toDomain(),
      );
    }
}
