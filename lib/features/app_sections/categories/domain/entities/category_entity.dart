import 'package:flower_app/features/app_sections/categories/domain/entities/category_item_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/metadata_entity.dart';

class CategoryEntity {
  final String message;
  final MetadataEntity metadata;
  final List<CategoryItemEntity> categories;
  CategoryEntity({
    required this.message,
    required this.metadata,
    required this.categories,
  });
 
}