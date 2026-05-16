import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/features/occasion/data/models/occasions_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'occasion_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class OccasionApiClient {
  @factoryMethod
  factory OccasionApiClient(Dio dio) = _OccasionApiClient;

  @GET(ApiEndpoints.occasions)
  Future<OccasionsResponse> getOccasions();
}
