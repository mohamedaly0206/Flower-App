import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/features/user_addresses/data/models/responses/user_addresses_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'user_addresses_api_client.g.dart';

@injectable
@RestApi()
abstract class UserAddressesApiClient {
  @factoryMethod
  factory UserAddressesApiClient(Dio dio) = _UserAddressesApiClient;
  @GET(ApiEndpoints.addresses)
  Future<UserAddressesDto> getUserAddresses();
  @DELETE("${ApiEndpoints.addresses}/{id}")
  Future<void> deleteAddress(@Path("id") String id);
}
