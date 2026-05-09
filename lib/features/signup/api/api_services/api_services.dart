import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/model/register_request.dart';
import '../../data/model/register_response.dart';

part 'api_services.g.dart';

@lazySingleton
@RestApi()
abstract class RegisterApiService {
  @factoryMethod
  factory RegisterApiService(Dio dio) = _RegisterApiService;

  @POST(ApiEndpoints.signUp)
  Future<RegisterResponse> register(@Body() RegisterRequest request);
}