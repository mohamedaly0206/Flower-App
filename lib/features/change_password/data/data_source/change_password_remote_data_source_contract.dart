import '../../../../config/base_response/base_response.dart';
import '../models/change_password_request_dto.dart';
import '../models/change_password_response_dto.dart';

abstract interface class ChangePasswordRemoteDataSourceContract {
  Future<BaseResponse<ChangePasswordResponseDto>> changePassword(
    ChangePasswordRequestDto changePasswordRequestDto,
  );
}
