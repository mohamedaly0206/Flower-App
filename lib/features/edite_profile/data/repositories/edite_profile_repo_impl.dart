import 'dart:io';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/edite_profile/data/datasources/edite_profile_remote_data_source.dart';
import 'package:flower_app/features/edite_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edite_profile/domain/repositories/edite_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditeProfileRepoContract)
class EditeProfileRepoImpl implements EditeProfileRepoContract {
  final EditeProfileRemoteDataSource _remoteDataSource;

  EditeProfileRepoImpl(this._remoteDataSource);

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
