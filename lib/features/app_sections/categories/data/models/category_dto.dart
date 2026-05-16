import 'package:flower_app/features/app_sections/categories/data/models/category_item_dto.dart';
import 'package:flower_app/features/app_sections/categories/data/models/metadata_dto.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/metadata_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetadataDto? metadata;
  @JsonKey(name: "categories")
  final List<CategoryItemDto>? categories;

  CategoryDto({this.message, this.metadata, this.categories});

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);
  CategoryEntity toDomain() {
    return CategoryEntity(
      message: message ?? '',
      metadata:
          metadata?.toDomain() ??
          MetadataEntity(
            currentPage: 0,
            limit: 0,
            totalPages: 0,
            totalItems: 0,
          ),
      categories: categories?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
