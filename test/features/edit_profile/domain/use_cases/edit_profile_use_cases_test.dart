import 'dart:io';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/edit_profile_repo_contract.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeEditProfileRepo implements EditProfileRepoContract {
  BaseResponse<UserProfileEntity>? getProfileResponse;
  BaseResponse<UserProfileEntity>? editProfileResponse;
  BaseResponse<UserProfileEntity>? uploadPhotoResponse;

  int getProfileCalls = 0;
  int editProfileCalls = 0;
  int uploadPhotoCalls = 0;

  Map<String, dynamic>? lastEditBody;
  File? lastFile;

  @override
  Future<BaseResponse<UserProfileEntity>> getProfile() async {
    getProfileCalls++;
    return getProfileResponse!;
  }

  @override
  Future<BaseResponse<UserProfileEntity>> editProfile(
    Map<String, dynamic> body,
  ) async {
    editProfileCalls++;
    lastEditBody = body;
    return editProfileResponse!;
  }

  @override
  Future<BaseResponse<UserProfileEntity>> uploadPhoto(File imageFile) async {
    uploadPhotoCalls++;
    lastFile = imageFile;
    return uploadPhotoResponse!;
  }
}

void main() {
  group('Edit Profile Use Cases Tests', () {
    late _FakeEditProfileRepo fakeRepo;
    late GetProfileUseCase getProfileUseCase;
    late EditProfileUseCase editProfileUseCase;
    late UploadProfilePhotoUseCase uploadProfilePhotoUseCase;

    final dummyUser = UserEntity(
      id: '123',
      firstName: 'Alice',
      lastName: 'Smith',
      email: 'alice@example.com',
      gender: 'female',
      phone: '123456789',
      photo: 'https://example.com/photo.jpg',
    );

    final dummyProfile = UserProfileEntity(message: 'success', user: dummyUser);

    setUp(() {
      fakeRepo = _FakeEditProfileRepo();
      getProfileUseCase = GetProfileUseCase(fakeRepo);
      editProfileUseCase = EditProfileUseCase(fakeRepo);
      uploadProfilePhotoUseCase = UploadProfilePhotoUseCase(fakeRepo);
    });

    test(
      'GetProfileUseCase forwards call to repository and returns response',
      () async {
        fakeRepo.getProfileResponse = SuccessBaseResponse(data: dummyProfile);

        final result = await getProfileUseCase();

        expect(result, isA<SuccessBaseResponse<UserProfileEntity>>());
        expect(
          (result as SuccessBaseResponse<UserProfileEntity>).data,
          dummyProfile,
        );
        expect(fakeRepo.getProfileCalls, 1);
      },
    );

    test('EditProfileUseCase forwards body map and returns response', () async {
      fakeRepo.editProfileResponse = SuccessBaseResponse(data: dummyProfile);
      const body = {'lastName': 'Tech2'};

      final result = await editProfileUseCase(body);

      expect(result, isA<SuccessBaseResponse<UserProfileEntity>>());
      expect(fakeRepo.editProfileCalls, 1);
      expect(fakeRepo.lastEditBody, body);
    });

    test(
      'UploadProfilePhotoUseCase forwards file and returns response',
      () async {
        fakeRepo.uploadPhotoResponse = SuccessBaseResponse(data: dummyProfile);
        final file = File('test_path.png');

        final result = await uploadProfilePhotoUseCase(file);

        expect(result, isA<SuccessBaseResponse<UserProfileEntity>>());
        expect(fakeRepo.uploadPhotoCalls, 1);
        expect(fakeRepo.lastFile, file);
      },
    );
  });
}
