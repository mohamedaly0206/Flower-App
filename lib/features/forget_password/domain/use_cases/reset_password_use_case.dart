import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:flower_app/features/forget_password/domain/repositories/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepoContract forgetPasswordRepoContract;

  ResetPasswordUseCase({required this.forgetPasswordRepoContract});

  Future<BaseResponse<ResetPasswordEntity>> call(ResetPasswordRequest request) {
    return forgetPasswordRepoContract.resetPassword(request);
  }
}
