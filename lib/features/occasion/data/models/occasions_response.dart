import 'package:flower_app/features/occasion/data/models/occasion_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasions_response.g.dart';

@JsonSerializable()
class OccasionsResponse {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'occasions')
  List<OccasionDTO>? occasions;

  OccasionsResponse({
    this.message,
    this.occasions,
  });

  factory OccasionsResponse.fromJson(Map<String, dynamic> json) =>
      _$OccasionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionsResponseToJson(this);
}
