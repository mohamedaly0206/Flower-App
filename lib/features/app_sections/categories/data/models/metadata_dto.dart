import 'package:flower_app/features/app_sections/categories/domain/entities/metadata_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata_dto.g.dart';

@JsonSerializable()
class MetadataDto {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  MetadataDto({this.currentPage, this.limit, this.totalPages, this.totalItems});

  factory MetadataDto.fromJson(Map<String, dynamic> json) =>
      _$MetadataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataDtoToJson(this);
  MetadataEntity toDomain() {
    return MetadataEntity(
      currentPage: currentPage ?? 0,
      limit: limit ?? 0,
      totalPages: totalPages ?? 0,
      totalItems: totalItems ?? 0,
    );
  }
}
