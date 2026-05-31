import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/change_password_response_entity.dart';

part 'change_password_response_dto.g.dart';

@JsonSerializable()
class ChangePasswordResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  ChangePasswordResponseDto({this.message, this.token});

  factory ChangePasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseDtoToJson(this);

  ChangePasswordResponseEntity toDomain() {
    return ChangePasswordResponseEntity(message: message);
  }
}
