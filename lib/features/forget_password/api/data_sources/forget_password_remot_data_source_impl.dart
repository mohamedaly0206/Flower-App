import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:flower_app/features/forget_password/data/data_sources/forget_password_remot_data_source_contract.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/data/models/responses/enter_reset_email_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/reset_password_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/verify_reset_code_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRemotDataSourceContract)
class ForgetPasswordRemotDataSourceImpl
    implements ForgetPasswordRemotDataSourceContract {
  ForgetPasswordApiClient forgetPasswordApiClient;
  ForgetPasswordRemotDataSourceImpl({required this.forgetPasswordApiClient});

  @override
  Future<BaseResponse<EnterResetEmailDTO>> enterResetEmail(
    EnterResetEmailRequest request,
  ) async {
    try {
      final response = await forgetPasswordApiClient.enterResetEmail(request);
      return SuccessBaseResponse<EnterResetEmailDTO>(data: response);
    } catch (e) {
      return ErrorBaseResponse<EnterResetEmailDTO>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<VerifyResetCodeDTO>> verifyResetCode(
    VerifyResetCodeRequest request,
  ) async {
    try {
      final response = await forgetPasswordApiClient.verifyResetCode(request);
      return SuccessBaseResponse<VerifyResetCodeDTO>(data: response);
    } catch (e) {
      return ErrorBaseResponse<VerifyResetCodeDTO>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<ResetPasswordDTO>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final response = await forgetPasswordApiClient.resetPassword(request);
      return SuccessBaseResponse<ResetPasswordDTO>(data: response);
    } catch (e) {
      return ErrorBaseResponse<ResetPasswordDTO>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
