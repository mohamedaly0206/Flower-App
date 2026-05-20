import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../core/errors/failures.dart';
import '../../data/data_source/change_password_remote_data_source_contract.dart';
import '../../data/models/change_password_request.dart';
import '../../data/models/change_password_response_dto.dart';
import '../api_client/change_password_api_client.dart';

@Injectable(as: ChangePasswordRemoteDataSourceContract)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSourceContract {
  final ChangePasswordApiClient changePasswordApiClient;

  const ChangePasswordRemoteDataSourceImpl(this.changePasswordApiClient);
  @override
  Future<BaseResponse<ChangePasswordResponseDto>> changePassword(
    ChangePasswordRequest changePasswordRequestDto,
  ) async {
    try {
      final response = await changePasswordApiClient.changePassword(
        changePasswordRequestDto: changePasswordRequestDto,
      );
      return SuccessBaseResponse<ChangePasswordResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<ChangePasswordResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
