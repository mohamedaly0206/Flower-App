import '../../../../config/base_response/base_response.dart';
import '../models/change_password_request.dart';
import '../models/change_password_response_dto.dart';

abstract interface class ChangePasswordRemoteDataSourceContract {
  Future<BaseResponse<ChangePasswordResponseDto>> changePassword(
    ChangePasswordRequest changePasswordRequestDto,
  );
}
