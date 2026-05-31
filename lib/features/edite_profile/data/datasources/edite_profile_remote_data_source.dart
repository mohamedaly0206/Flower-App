import 'dart:io';
import 'package:flower_app/features/edite_profile/data/models/responses/user_profile_dto.dart';

abstract interface class EditeProfileRemoteDataSource {
  Future<UserProfileDto> getProfile();
  Future<UserProfileDto> editProfile(Map<String, dynamic> body);
  Future<UserProfileDto> uploadPhoto(File imageFile);
}
