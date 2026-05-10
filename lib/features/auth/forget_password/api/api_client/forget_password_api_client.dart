import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/responses/enter_reset_email_dto.dart';
import 'package:flower_app/features/auth/forget_password/data/models/responses/reset_password_dto.dart';
import 'package:flower_app/features/auth/forget_password/data/models/responses/verify_reset_code_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'forget_password_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;
  @Extra({AppStrings.noToken: true})
  @POST(ApiEndpoints.forgetPassword)
  Future<EnterResetEmailDTO> enterResetEmail(
    @Body() EnterResetEmailRequest request,
  );

  @POST(ApiEndpoints.verifyResetCode)
  Future<VerifyResetCodeDTO> verifyResetCode(
    @Body() VerifyResetCodeRequest request,
  );

  @PUT(ApiEndpoints.resetPassword)
  Future<ResetPasswordDTO> resetPassword(@Body() ResetPasswordRequest request);
}
