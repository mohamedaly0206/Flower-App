import 'package:flower_app/features/checkout/domain/entities/response/credit_card/session_metadata_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_metadata_dto.g.dart';

@JsonSerializable()
class SessionMetadataDto {
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "lat")
  final String? lat;
  @JsonKey(name: "long")
  final String? long;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "street")
  final String? street;

  SessionMetadataDto({this.city, this.lat, this.long, this.phone, this.street});

  factory SessionMetadataDto.fromJson(Map<String, dynamic> json) =>
      _$SessionMetadataDtoFromJson(json);
  Map<String, dynamic> toJson() => _$SessionMetadataDtoToJson(this);
  SessionMetadataEntity toDomain() {
    return SessionMetadataEntity(
      city: city,
      lat: lat,
      long: long,
      phone: phone,
      street: street,
    );
  }
}
