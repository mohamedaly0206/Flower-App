import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasion_dto.g.dart';

@JsonSerializable()
class OccasionDTO {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'slug')
  String? slug;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'isSuperAdmin')
  bool? isSuperAdmin;

  @JsonKey(name: 'createdAt')
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;

  @JsonKey(name: 'productsCount')
  int? productsCount;

  OccasionDTO({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });

  factory OccasionDTO.fromJson(Map<String, dynamic> json) =>
      _$OccasionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionDTOToJson(this);
  OccasionEntity toEntity() {
    return OccasionEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
    );
  }
}
