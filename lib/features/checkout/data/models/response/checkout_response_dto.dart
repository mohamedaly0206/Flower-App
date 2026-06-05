import 'package:flower_app/features/checkout/data/models/response/order_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/response/checkout_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'checkout_response_dto.g.dart';

CheckoutResponseDto checkoutResponseDtoFromJson(String str) => CheckoutResponseDto.fromJson(json.decode(str));

String checkoutResponseDtoToJson(CheckoutResponseDto data) => json.encode(data.toJson());

@JsonSerializable()
class CheckoutResponseDto {
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "order")
    final OrderDto? order;

    CheckoutResponseDto({
        this.message,
        this.order,
    });

    factory CheckoutResponseDto.fromJson(Map<String, dynamic> json) => _$CheckoutResponseDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CheckoutResponseDtoToJson(this);

    CheckoutResponseEntity toDomain() {
      return CheckoutResponseEntity(
        message: message,
        order: order?.toDomain(),
      );
    }
}



