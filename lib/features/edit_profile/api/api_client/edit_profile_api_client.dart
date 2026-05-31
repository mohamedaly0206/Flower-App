import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/features/edit_profile/data/models/responses/user_profile_dto.dart';

part 'edite_profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(ApiEndpoints.getLoggedUserData)
  Future<UserProfileDto> getProfile();

  @PUT(ApiEndpoints.editProfile)
  Future<UserProfileDto> editProfile(@Body() Map<String, dynamic> body);

  @PUT(ApiEndpoints.uploadProfilePhoto)
  @MultiPart()
  Future<UserProfileDto> uploadPhoto(@Part(name: 'photo') MultipartFile photo);
}
