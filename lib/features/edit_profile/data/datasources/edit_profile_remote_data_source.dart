import 'dart:io';
import 'package:flower_app/features/edit_profile/data/models/responses/user_profile_dto.dart';

abstract interface class EditProfileRemoteDataSource {
  Future<UserProfileDto> getProfile();
  Future<UserProfileDto> editProfile(Map<String, dynamic> body);
  Future<UserProfileDto> uploadPhoto(File imageFile);
}
