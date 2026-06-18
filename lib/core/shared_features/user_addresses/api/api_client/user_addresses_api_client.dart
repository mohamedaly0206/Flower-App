import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/core/shared_features/user_addresses/data/models/responses/user_addresses_dto.dart';
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
  @PATCH(ApiEndpoints.addresses)
  Future<void> addAddress(@Body() Map<String, dynamic> body);
  @PATCH("${ApiEndpoints.addresses}/{id}")
  Future<void> updateAddress(
    @Path("id") String id,
    @Body() Map<String, dynamic> body,
  );
  @DELETE("${ApiEndpoints.addresses}/{id}")
  Future<void> deleteAddress(@Path("id") String id);
}
