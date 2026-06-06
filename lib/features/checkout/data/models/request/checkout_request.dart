import 'package:flower_app/features/checkout/data/models/request/shipping_address_dto.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'checkout_request.g.dart';

CheckoutRequest checkoutRequestFromJson(String str) =>
    CheckoutRequest.fromJson(json.decode(str));

String checkoutRequestToJson(CheckoutRequest data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CheckoutRequest {
  @JsonKey(name: "shippingAddress")
  final ShippingAddress? shippingAddress;

  CheckoutRequest({required this.shippingAddress});

  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestToJson(this);
}
