import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';

abstract interface class CategoriesRepoContract {
  Future<BaseResponse<CategoryEntity>> getCategories();
}
