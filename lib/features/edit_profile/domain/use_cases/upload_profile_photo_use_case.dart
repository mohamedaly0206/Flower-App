import 'dart:io';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/edit_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadProfilePhotoUseCase {
  final EditProfileRepoContract _repository;

  UploadProfilePhotoUseCase(this._repository);

  Future<BaseResponse<UserProfileEntity>> call(File imageFile) {
    return _repository.uploadPhoto(imageFile);
  }
}
