import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/enter_reset_email_entity.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/reset_password_entity.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/verify_reset_code_entity.dart';

abstract interface class ForgetPasswordRepoContract {
  Future<BaseResponse<EnterResetEmailEntity>> enterResetEmail(
    EnterResetEmailRequest request,
  );
  Future<BaseResponse<VerifyResetCodeEntity>> verifyResetCode(
    VerifyResetCodeRequest request,
  );
  Future<BaseResponse<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequest request,
  );
}
