import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/app_sections/categories/data/models/category_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_api_client.g.dart';
@singleton
@RestApi()
abstract class CategoriesApiClient {
@factoryMethod
  factory CategoriesApiClient(Dio dio) => _CategoriesApiClient(dio);
  @Extra({AppStrings.noToken: true})
  @GET(ApiEndpoints.categories)
  Future<CategoryDto> getCategories();

}