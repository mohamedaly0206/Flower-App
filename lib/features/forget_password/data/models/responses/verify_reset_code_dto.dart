import 'package:flower_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'verify_reset_code_dto.g.dart';

@JsonSerializable()
class VerifyResetCodeDTO {
  final String status;

  VerifyResetCodeDTO({required this.status});

  factory VerifyResetCodeDTO.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeDTOFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeDTOToJson(this);

  VerifyResetCodeEntity toDomain() => VerifyResetCodeEntity(status: status);
}
