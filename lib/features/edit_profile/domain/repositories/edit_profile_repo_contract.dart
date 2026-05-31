import 'dart:io';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';

abstract interface class EditProfileRepoContract {
  Future<BaseResponse<UserProfileEntity>> getProfile();
  Future<BaseResponse<UserProfileEntity>> editProfile(
    Map<String, dynamic> body,
  );
  Future<BaseResponse<UserProfileEntity>> uploadPhoto(File imageFile);
}
