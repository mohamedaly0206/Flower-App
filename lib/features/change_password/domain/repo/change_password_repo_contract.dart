import 'package:flower_app/features/change_password/data/models/change_password_request.dart';
import '../../../../config/base_response/base_response.dart';
import '../entities/change_password_response_entity.dart';

abstract interface class ChangePasswordRepoContract {
  Future<BaseResponse<ChangePasswordResponseEntity>> changePassword(
    ChangePasswordRequest changePasswordRequestEntity,
  );
}
