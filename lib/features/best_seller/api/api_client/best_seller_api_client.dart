import 'package:dio/dio.dart';
import 'package:flower_app/core/shared_features/products/data/models/products_response.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'best_seller_api_client.g.dart';

@injectable
@RestApi()
abstract class BestSellerApiClient {
  @factoryMethod
  factory BestSellerApiClient(Dio dio) = _BestSellerApiClient;

  @GET(ApiEndpoints.bestSeller)
  Future<ProductsResponseDto> getBestSellers();
}
