import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flower_app/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:flower_app/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:flower_app/features/edit_profile/data/models/responses/user_profile_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRemoteDataSource)
class EditeProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final ProfileApiClient _apiClient;

  EditeProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserProfileDto> getProfile() {
    return _apiClient.getProfile();
  }

  @override
  Future<UserProfileDto> editProfile(Map<String, dynamic> body) {
    return _apiClient.editProfile(body);
  }

  @override
  Future<UserProfileDto> uploadPhoto(File imageFile) async {
    final path = imageFile.path;
    final fileName = path.split(RegExp(r'[/\\]')).last;
    return _apiClient.uploadPhoto(
      await MultipartFile.fromFile(
        path,
        filename: fileName.isNotEmpty ? fileName : 'photo.jpg',
      ),
    );
  }
}
