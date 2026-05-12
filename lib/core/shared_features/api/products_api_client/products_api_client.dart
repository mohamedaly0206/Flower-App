import 'package:dio/dio.dart';
import 'package:flower_app/core/shared_features/data/models/products_response.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'products_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProductsApiClient {
  @factoryMethod
  factory ProductsApiClient(Dio dio) = _ProductsApiClient;

  @GET(ApiEndpoints.products)
  Future<ProductsResponse> getProducts({
    @Query("category") String? categoryId,
    @Query("occasion") String? occasionId,
  });
}
