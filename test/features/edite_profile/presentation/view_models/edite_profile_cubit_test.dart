import 'dart:io';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/edite_profile/domain/entities/edit_profile_body.dart';
import 'package:flower_app/features/edite_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edite_profile/domain/repositories/edite_profile_repo_contract.dart';
import 'package:flower_app/features/edite_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flower_app/features/edite_profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flower_app/features/edite_profile/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:flower_app/features/edite_profile/presentation/view_model/cubit/edite_profile_cubit.dart';
import 'package:flower_app/features/edite_profile/presentation/view_model/intent/edite_profile_intent.dart';
import 'package:flower_app/features/edite_profile/presentation/view_model/state/edite_profile_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeEditeProfileRepo implements EditeProfileRepoContract {
  BaseResponse<UserProfileEntity>? getProfileResponse;
  BaseResponse<UserProfileEntity>? editProfileResponse;
  BaseResponse<UserProfileEntity>? uploadPhotoResponse;

  Map<String, dynamic>? lastEditBody;
  int getProfileCalls = 0;

  @override
  Future<BaseResponse<UserProfileEntity>> getProfile() async {
    getProfileCalls++;
    return getProfileResponse!;
  }

  @override
  Future<BaseResponse<UserProfileEntity>> editProfile(
    Map<String, dynamic> body,
  ) async {
    lastEditBody = body;
    return editProfileResponse!;
  }

  @override
  Future<BaseResponse<UserProfileEntity>> uploadPhoto(File imageFile) async {
    return uploadPhotoResponse!;
  }
}

void main() {
  group('EditeProfileCubit MVI Tests', () {
    late _FakeEditeProfileRepo fakeRepo;
    late GetProfileUseCase getProfileUseCase;
    late EditProfileUseCase editProfileUseCase;
    late UploadProfilePhotoUseCase uploadProfilePhotoUseCase;
    late EditeProfileCubit cubit;

    final dummyUser = UserEntity(
      id: '123',
      firstName: 'Alice',
      lastName: 'Smith',
      email: 'alice@example.com',
      gender: 'female',
      phone: '123456789',
      photo: 'https://example.com/photo.jpg',
    );

    final dummyProfile = UserProfileEntity(
      message: 'Profile details fetched',
      user: dummyUser,
    );

    setUp(() {
      fakeRepo = _FakeEditeProfileRepo();
      getProfileUseCase = GetProfileUseCase(fakeRepo);
      editProfileUseCase = EditProfileUseCase(fakeRepo);
      uploadProfilePhotoUseCase = UploadProfilePhotoUseCase(fakeRepo);
      cubit = EditeProfileCubit(
        getProfileUseCase,
        editProfileUseCase,
        uploadProfilePhotoUseCase,
      );
    });

    tearDown(() async {
      await cubit.close();
    });

    test('initial state has correct default values', () {
      expect(cubit.state.status, EditeProfileStatus.initial);
      expect(cubit.state.user, isNull);
      expect(cubit.state.errorMessage, isNull);
      expect(cubit.state.successMessage, isNull);
    });

    test('FetchProfileIntent normalizes API gender to lowercase signup values', () async {
      final profileFromApi = UserProfileEntity(
        message: 'success',
        user: dummyUser.copyWith(gender: 'Female'),
      );
      fakeRepo.getProfileResponse = SuccessBaseResponse(data: profileFromApi);

      cubit.handleIntent(const FetchProfileIntent());
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.user?.gender, 'female');
    });

    test('FetchProfileIntent emits [loading, success] on success', () async {
      fakeRepo.getProfileResponse = SuccessBaseResponse(data: dummyProfile);

      final emitted = <EditeProfileState>[];
      final sub = cubit.stream.listen(emitted.add);

      cubit.handleIntent(const FetchProfileIntent());
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(emitted, hasLength(2));
      expect(emitted[0].status, EditeProfileStatus.loading);
      expect(emitted[1].status, EditeProfileStatus.success);
      expect(emitted[1].user, dummyUser);
    });

    test('FetchProfileIntent emits [loading, error] on error', () async {
      fakeRepo.getProfileResponse = ErrorBaseResponse(
        errorMessage: 'Network error',
      );

      final emitted = <EditeProfileState>[];
      final sub = cubit.stream.listen(emitted.add);

      cubit.handleIntent(const FetchProfileIntent());
      await Future<void>.delayed(Duration.zero);
      await sub.cancel();

      expect(emitted, hasLength(2));
      expect(emitted[0].status, EditeProfileStatus.loading);
      expect(emitted[1].status, EditeProfileStatus.error);
      expect(emitted[1].errorMessage, 'Network error');
    });

    test(
      'Update Intents update local user state fields locally without calling API',
      () async {
        fakeRepo.getProfileResponse = SuccessBaseResponse(data: dummyProfile);
        cubit.handleIntent(const FetchProfileIntent());
        await Future<void>.delayed(Duration.zero);

        expect(cubit.state.user?.firstName, 'Alice');

        cubit.handleIntent(const UpdateFirstNameIntent('Bob'));
        expect(cubit.state.user?.firstName, 'Bob');

        cubit.handleIntent(const UpdateLastNameIntent('Jones'));
        expect(cubit.state.user?.lastName, 'Jones');

        cubit.handleIntent(const UpdatePhoneIntent('555666777'));
        expect(cubit.state.user?.phone, '555666777');

        cubit.handleIntent(const UpdateGenderIntent('male'));
        expect(cubit.state.user?.gender, 'male');
      },
    );

    test(
      'UploadPhotoIntent refetches profile when API returns message-only',
      () async {
        fakeRepo.getProfileResponse = SuccessBaseResponse(data: dummyProfile);
        cubit.handleIntent(const FetchProfileIntent());
        await Future<void>.delayed(Duration.zero);

        final updatedUser = dummyUser.copyWith(
          photo: 'https://example.com/new_photo.jpg',
        );
        fakeRepo.uploadPhotoResponse = SuccessBaseResponse(
          data: UserProfileEntity(message: 'success'),
        );
        fakeRepo.getProfileResponse = SuccessBaseResponse(
          data: UserProfileEntity(message: 'success', user: updatedUser),
        );

        final emitted = <EditeProfileState>[];
        final sub = cubit.stream.listen(emitted.add);

        cubit.handleIntent(UploadPhotoIntent(File('test.png')));
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        expect(fakeRepo.getProfileCalls, 2);
        expect(emitted.last.status, EditeProfileStatus.success);
        expect(emitted.last.user?.photo, 'https://example.com/new_photo.jpg');
        expect(emitted.last.localPhotoFile, isNull);
      },
    );

    test(
      'SubmitProfileUpdateIntent sends partial body and updates on success',
      () async {
        fakeRepo.getProfileResponse = SuccessBaseResponse(data: dummyProfile);
        cubit.handleIntent(const FetchProfileIntent());
        await Future<void>.delayed(Duration.zero);

        cubit.handleIntent(const UpdateFirstNameIntent('Bob'));
        cubit.handleIntent(const UpdateLastNameIntent('Jones'));
        cubit.handleIntent(const UpdatePhoneIntent('555666777'));
        cubit.handleIntent(const UpdateGenderIntent('male'));

        final finalUser = dummyUser.copyWith(
          firstName: 'Bob',
          lastName: 'Jones',
          phone: '555666777',
          gender: 'male',
        );
        final finalProfileResponse = UserProfileEntity(
          message: 'Profile updated successfully',
          user: finalUser,
        );
        fakeRepo.editProfileResponse = SuccessBaseResponse(
          data: finalProfileResponse,
        );

        final emitted = <EditeProfileState>[];
        final sub = cubit.stream.listen(emitted.add);

        cubit.handleIntent(const SubmitProfileUpdateIntent());
        await Future<void>.delayed(Duration.zero);
        await sub.cancel();

        expect(fakeRepo.lastEditBody, {
          'firstName': 'Bob',
          'lastName': 'Jones',
          'phone': '555666777',
          'gender': 'male',
        });
        expect(emitted, hasLength(2));
        expect(emitted[0].status, EditeProfileStatus.loading);
        expect(emitted[1].status, EditeProfileStatus.success);
        expect(emitted[1].user?.firstName, 'Bob');
        expect(emitted[1].user?.lastName, 'Jones');
        expect(emitted[1].successMessage, 'Profile updated successfully');
      },
    );

    test(
      'SubmitProfileUpdateIntent sends email and preserves gender when API response is stale',
      () async {
        fakeRepo.getProfileResponse = SuccessBaseResponse(data: dummyProfile);
        cubit.handleIntent(const FetchProfileIntent());
        await Future<void>.delayed(Duration.zero);

        cubit.handleIntent(const UpdateEmailIntent('newemail@test.com'));
        cubit.handleIntent(const UpdateGenderIntent('male'));

        fakeRepo.editProfileResponse = SuccessBaseResponse(
          data: UserProfileEntity(
            message: 'Profile updated successfully',
            user: dummyUser.copyWith(
              email: 'old@example.com',
              gender: 'female',
            ),
          ),
        );

        cubit.handleIntent(const SubmitProfileUpdateIntent());
        await Future<void>.delayed(Duration.zero);

        expect(fakeRepo.lastEditBody, {
          'email': 'newemail@test.com',
          'gender': 'male',
        });
        expect(cubit.state.user?.email, 'newemail@test.com');
        expect(cubit.state.user?.gender, 'male');
      },
    );

    test('mergeEditProfileSuccessUser keeps submitted email and gender', () {
      final local = UserEntity(
        id: '1',
        firstName: 'A',
        lastName: 'B',
        email: 'new@test.com',
        gender: 'male',
        phone: '1',
      );
      final staleApi = UserEntity(
        id: '1',
        firstName: 'A',
        lastName: 'B',
        email: 'old@test.com',
        gender: 'female',
        phone: '1',
      );
      final merged = mergeEditProfileSuccessUser(
        localUser: local,
        responseUser: staleApi,
        sentBody: {'email': 'new@test.com', 'gender': 'male'},
      );
      expect(merged.email, 'new@test.com');
      expect(merged.gender, 'male');
    });

    test('SubmitProfileUpdateIntent emits error when no changes', () async {
      fakeRepo.getProfileResponse = SuccessBaseResponse(data: dummyProfile);
      cubit.handleIntent(const FetchProfileIntent());
      await Future<void>.delayed(Duration.zero);

      cubit.handleIntent(const SubmitProfileUpdateIntent());
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.status, EditeProfileStatus.error);
      expect(cubit.state.errorMessage, 'No changes to save');
      expect(fakeRepo.lastEditBody, isNull);
    });

    test('SubmitProfileUpdateIntent rejects invalid email', () async {
      fakeRepo.getProfileResponse = SuccessBaseResponse(data: dummyProfile);
      cubit.handleIntent(const FetchProfileIntent());
      await Future<void>.delayed(Duration.zero);

      cubit.handleIntent(const UpdateEmailIntent('not-an-email'));
      cubit.handleIntent(const SubmitProfileUpdateIntent());
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.status, EditeProfileStatus.error);
      expect(cubit.state.errorMessage, 'Please enter a valid email address');
      expect(fakeRepo.lastEditBody, isNull);
    });
  });
}
