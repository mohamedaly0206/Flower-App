import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:flower_app/features/forget_password/domain/repositories/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetCodeUseCase {
  final ForgetPasswordRepoContract forgetPasswordRepoContract;

  VerifyResetCodeUseCase({required this.forgetPasswordRepoContract});

  Future<BaseResponse<VerifyResetCodeEntity>> call(
    VerifyResetCodeRequest request,
  ) {
    return forgetPasswordRepoContract.verifyResetCode(request);
  }
}
