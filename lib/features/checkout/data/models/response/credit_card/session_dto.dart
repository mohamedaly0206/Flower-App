import 'package:flower_app/features/checkout/data/models/response/credit_card/session_metadata_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/response/credit_card/session_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "cancel_url")
  final String? cancelUrl;
  @JsonKey(name: "client_reference_id")
  final String? clientReferenceId;
  @JsonKey(name: "customer_email")
  final String? customerEmail;
  @JsonKey(name: "metadata")
  final SessionMetadataDto? metadata;
  @JsonKey(name: "payment_status")
  final String? paymentStatus;
  @JsonKey(name: "success_url")
  final String? successUrl;
  @JsonKey(name: "url")
  final String? url;

  SessionDto({
    this.id,
    this.cancelUrl,
    this.clientReferenceId,
    this.customerEmail,
    this.metadata,
    this.paymentStatus,
    this.successUrl,
    this.url,
  });

  factory SessionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);
  SessionEntity toDomain() {
    return SessionEntity(
      id: id,
      cancelUrl: cancelUrl,
      clientReferenceId: clientReferenceId,
      customerEmail: customerEmail,
      metadata: metadata?.toDomain(),
      paymentStatus: paymentStatus,
      successUrl: successUrl,
      url: url,
    );
  }
}
