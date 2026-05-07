import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/forget_password/data/data_sources/forget_password_remote_data_source_contract.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/data/models/responses/enter_reset_email_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/reset_password_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/verify_reset_code_dto.dart';
import 'package:flower_app/features/forget_password/domain/entities/enter_reset_email_entity.dart';
import 'package:flower_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:flower_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:flower_app/features/forget_password/domain/repositories/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRepoContract)
class ForgetPasswordRepoImpl implements ForgetPasswordRepoContract {
  ForgetPasswordRemoteDataSourceContract forgetPasswordRemoteDataSourceContract;
  ForgetPasswordRepoImpl(this.forgetPasswordRemoteDataSourceContract);
  @override
  Future<BaseResponse<EnterResetEmailEntity>> enterResetEmail(
    EnterResetEmailRequest request,
  ) async {
    final response = await forgetPasswordRemoteDataSourceContract
        .enterResetEmail(request);
    switch (response) {
      case SuccessBaseResponse<EnterResetEmailDTO>():
        return SuccessBaseResponse<EnterResetEmailEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<EnterResetEmailDTO>():
        return ErrorBaseResponse<EnterResetEmailEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    final response = await forgetPasswordRemoteDataSourceContract.resetPassword(
      request,
    );
    switch (response) {
      case SuccessBaseResponse<ResetPasswordDTO>():
        return SuccessBaseResponse<ResetPasswordEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<ResetPasswordDTO>():
        return ErrorBaseResponse<ResetPasswordEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<VerifyResetCodeEntity>> verifyResetCode(
    VerifyResetCodeRequest request,
  ) async {
    final response = await forgetPasswordRemoteDataSourceContract
        .verifyResetCode(request);
    switch (response) {
      case SuccessBaseResponse<VerifyResetCodeDTO>():
        return SuccessBaseResponse<VerifyResetCodeEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<VerifyResetCodeDTO>():
        return ErrorBaseResponse<VerifyResetCodeEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
