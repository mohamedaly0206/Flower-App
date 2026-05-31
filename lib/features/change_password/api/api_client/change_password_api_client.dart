import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/values/api_endpoints.dart';
import '../../data/models/change_password_request.dart';
import '../../data/models/change_password_response_dto.dart';

part 'change_password_api_client.g.dart';

@injectable
@RestApi()
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio) = _ChangePasswordApiClient;
  @PATCH(ApiEndpoints.changePassword)
  Future<ChangePasswordResponseDto> changePassword({
    @Body() required ChangePasswordRequest changePasswordRequestDto,
  });
}
