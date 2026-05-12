
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/app_sections/categories/api/categories_api_client/categories_api_client.dart';
import 'package:flower_app/features/app_sections/categories/data/datasources/category_remote_data_source_contract.dart';
import 'package:flower_app/features/app_sections/categories/data/models/category_dto.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: CategoriesRemoteDataSourceContract)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSourceContract {
  final CategoriesApiClient categoriesApiClient;

  CategoriesRemoteDataSourceImpl({required this.categoriesApiClient});
  @override
  Future<BaseResponse<CategoryDto>> getCategories() async{
    try{
     final response=await categoriesApiClient.getCategories();
return SuccessBaseResponse<CategoryDto>(data: response);
    }
    catch(e){
      return ErrorBaseResponse<CategoryDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}