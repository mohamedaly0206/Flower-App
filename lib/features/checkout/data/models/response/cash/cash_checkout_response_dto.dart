import 'package:flower_app/features/checkout/data/models/response/cash/order_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/response/cash/cash_checkout_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'cash_checkout_response_dto.g.dart';

CashCheckoutResponseDto checkoutResponseDtoFromJson(String str) =>
    CashCheckoutResponseDto.fromJson(json.decode(str));

String checkoutResponseDtoToJson(CashCheckoutResponseDto data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CashCheckoutResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "order")
  final OrderDto? order;

  CashCheckoutResponseDto({this.message, this.order});

  factory CashCheckoutResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CashCheckoutResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CashCheckoutResponseDtoToJson(this);

  CashCheckoutResponseEntity toDomain() {
    return CashCheckoutResponseEntity(
      message: message,
      order: order?.toDomain(),
    );
  }
}
