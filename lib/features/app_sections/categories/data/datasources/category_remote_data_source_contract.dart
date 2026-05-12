import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/categories/data/models/category_dto.dart';

abstract interface class CategoriesRemoteDataSourceContract {
  Future<BaseResponse<CategoryDto>> getCategories();
}