import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/categories/data/datasources/category_remote_data_source_contract.dart';
import 'package:flower_app/features/app_sections/categories/data/models/category_dto.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/repositories/categories_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepoContract)
class CategoriesRepoImpl implements CategoriesRepoContract {
  final CategoriesRemoteDataSourceContract categoryRemoteDataSource;

  CategoriesRepoImpl({required this.categoryRemoteDataSource});
  @override
  Future<BaseResponse<CategoryEntity>> getCategories() async {
    final response = await categoryRemoteDataSource.getCategories();
    switch (response) {
      case SuccessBaseResponse<CategoryDto>():
        return SuccessBaseResponse<CategoryEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CategoryDto>():
        return ErrorBaseResponse<CategoryEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
