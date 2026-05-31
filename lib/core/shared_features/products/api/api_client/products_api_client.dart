import 'package:dio/dio.dart';
import 'package:flower_app/core/shared_features/products/data/models/products_response.dart';
import 'package:flower_app/core/values/api_endpoints.dart';

import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../values/app_strings.dart';

part 'products_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProductsApiClient {
  @factoryMethod
  factory ProductsApiClient(Dio dio) = _ProductsApiClient;
  @Extra({AppStrings.noToken: true})
  @GET(ApiEndpoints.products)
  Future<ProductsResponseDto> getProducts({
    @Query("category") String? categoryId,
    @Query("occasion") String? occasionId,
    @Query("search") String? search,
  });
}
