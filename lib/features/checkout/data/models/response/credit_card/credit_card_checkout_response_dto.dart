import 'package:flower_app/features/checkout/data/models/response/credit_card/session_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/response/credit_card/credit_card_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'credit_card_checkout_response_dto.g.dart';

@JsonSerializable()
class CreditCardCheckoutResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "session")
  final SessionDto? session;

  CreditCardCheckoutResponseDto({this.message, this.session});

  factory CreditCardCheckoutResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreditCardCheckoutResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreditCardCheckoutResponseDtoToJson(this);
  CreditCardCheckoutResponseEntity toDomain() {
    return CreditCardCheckoutResponseEntity(
      message: message,
      session: session?.toDomain(),
    );
  }
}
