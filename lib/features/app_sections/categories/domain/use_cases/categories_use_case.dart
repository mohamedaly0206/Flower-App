import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/repositories/categories_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesUseCase {
  final CategoriesRepoContract categoriesRepoContract;

  CategoriesUseCase({required this.categoriesRepoContract});
  Future<BaseResponse<CategoryEntity>> getCategories() {
    return categoriesRepoContract.getCategories();
  }
}
