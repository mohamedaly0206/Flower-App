import 'package:flower_app/features/app_sections/categories/domain/entities/category_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_item_dto.g.dart';

@JsonSerializable()
class CategoryItemDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "productsCount")
  final int? productsCount;

  CategoryItemDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });

  factory CategoryItemDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemDtoToJson(this);
  CategoryItemEntity toDomain() {
    return CategoryItemEntity(
      id: id ?? '',
      name: name ?? '',
      image: image ?? '',
    );
  }
}
