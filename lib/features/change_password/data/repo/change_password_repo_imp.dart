import 'package:flower_app/features/change_password/data/models/change_password_request_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/change_password_response_entity.dart';
import '../../domain/repo/change_password_repo_contract.dart';
import '../data_source/change_password_remote_data_source_contract.dart';
import '../models/change_password_response_dto.dart';

@Injectable(as: ChangePasswordRepoContract)
class ChangePasswordRepoImpl implements ChangePasswordRepoContract {
  final ChangePasswordRemoteDataSourceContract _dataSource;
  const ChangePasswordRepoImpl(this._dataSource);

  @override
  Future<BaseResponse<ChangePasswordResponseEntity>> changePassword(
      ChangePasswordRequestDto changePasswordRequestDto,
      ) async {
    final response = await _dataSource.changePassword(
      changePasswordRequestDto,
    );

    switch (response) {
      case SuccessBaseResponse<ChangePasswordResponseDto>():
        return SuccessBaseResponse(data: response.data.toDomain());
      case ErrorBaseResponse<ChangePasswordResponseDto>():
        return ErrorBaseResponse(errorMessage: response.errorMessage);
    }
  }
}