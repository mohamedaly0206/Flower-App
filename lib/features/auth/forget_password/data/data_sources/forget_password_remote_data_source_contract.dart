import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/responses/enter_reset_email_dto.dart';
import 'package:flower_app/features/auth/forget_password/data/models/responses/reset_password_dto.dart';
import 'package:flower_app/features/auth/forget_password/data/models/responses/verify_reset_code_dto.dart';

abstract interface class ForgetPasswordRemoteDataSourceContract {
  Future<BaseResponse<EnterResetEmailDTO>> enterResetEmail(
    EnterResetEmailRequest request,
  );
  Future<BaseResponse<VerifyResetCodeDTO>> verifyResetCode(
    VerifyResetCodeRequest request,
  );
  Future<BaseResponse<ResetPasswordDTO>> resetPassword(
    ResetPasswordRequest request,
  );
}
