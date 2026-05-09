import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/domain/entities/enter_reset_email_entity.dart';
import 'package:flower_app/features/forget_password/domain/repositories/forget_password_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class EnterResetEmailUseCase {
  final ForgetPasswordRepoContract forgetPasswordRepoContract;

  EnterResetEmailUseCase({required this.forgetPasswordRepoContract});

  Future<BaseResponse<EnterResetEmailEntity>> call(
    EnterResetEmailRequest request,
  ) {
    return forgetPasswordRepoContract.enterResetEmail(request);
  }
}
