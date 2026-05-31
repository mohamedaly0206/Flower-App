import 'dart:io';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepoContract)
class EditProfileRepoImpl implements EditProfileRepoContract {
  final EditProfileRemoteDataSource _remoteDataSource;

  EditProfileRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<UserProfileEntity>> getProfile() async {
    try {
      final response = await _remoteDataSource.getProfile();
      return SuccessBaseResponse(data: response.toEntity());
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<UserProfileEntity>> editProfile(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _remoteDataSource.editProfile(body);
      return SuccessBaseResponse(data: response.toEntity());
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<UserProfileEntity>> uploadPhoto(File imageFile) async {
    try {
      final response = await _remoteDataSource.uploadPhoto(imageFile);
      return SuccessBaseResponse(data: response.toEntity());
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }
}
