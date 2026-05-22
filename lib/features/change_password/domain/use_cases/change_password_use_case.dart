import 'package:flower_app/features/change_password/data/models/change_password_request.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/change_password_response_entity.dart';
import '../repo/change_password_repo_contract.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepoContract changePasswordRepoContract;
  ChangePasswordUseCase(this.changePasswordRepoContract);
  Future<BaseResponse<ChangePasswordResponseEntity>> call(
    ChangePasswordRequest changePasswordRequest,
  ) async {
    return await changePasswordRepoContract.changePassword(
      changePasswordRequest,
    );
  }
}
