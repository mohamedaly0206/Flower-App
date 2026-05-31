import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/intent/profile_intent.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/state/profile_states.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([FlutterSecureStorage])
import 'profile_cubit_test.mocks.dart';

void main() {
  late MockFlutterSecureStorage mockSecureStorage;
  late ProfileCubit profileCubit;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    profileCubit = ProfileCubit(mockSecureStorage);
  });

  tearDown(() {
    profileCubit.close();
  });

  group('ProfileCubit MVI Tests', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [ProfileLoading, ProfileSuccess] when LoadUserProfileIntent is successful',
      build: () {
        when(
          mockSecureStorage.read(key: ApiParam.userName),
        ).thenAnswer((_) async => 'Ahmed');
        when(
          mockSecureStorage.read(key: ApiParam.userEmail),
        ).thenAnswer((_) async => 'ahmed@example.com');
        when(
          mockSecureStorage.read(key: ApiParam.userPhoto),
        ).thenAnswer((_) async => 'photo_url');
        when(
          mockSecureStorage.read(key: ApiParam.languageCode),
        ).thenAnswer((_) async => 'en');
        return profileCubit;
      },
      act: (cubit) => cubit.doIntent(LoadUserProfileIntent()),
      expect: () => [
        const ProfileLoading(),
        const ProfileSuccess(
          name: 'Ahmed',
          email: 'ahmed@example.com',
          photoUrl: 'photo_url',
          languageCode: 'en',
        ),
      ],
      verify: (_) {
        verify(mockSecureStorage.read(key: ApiParam.userName)).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [ProfileLoading, ProfileError] when LoadUserProfileIntent throws exception',
      build: () {
        when(
          mockSecureStorage.read(key: anyNamed('key')),
        ).thenThrow(Exception('Storage error'));
        return profileCubit;
      },
      act: (cubit) => cubit.doIntent(LoadUserProfileIntent()),
      expect: () => [
        const ProfileLoading(),
        const ProfileError('Failed to load profile data'),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [ProfileSuccess] with updated language when ChangeLanguageIntent is triggered',
      build: () {
        when(
          mockSecureStorage.write(key: ApiParam.languageCode, value: 'ar'),
        ).thenAnswer((_) async => {});
        return profileCubit;
      },
      seed: () => const ProfileSuccess(
        name: 'Ahmed',
        email: 'ahmed@example.com',
        photoUrl: 'photo_url',
        languageCode: 'en',
      ),
      act: (cubit) => cubit.doIntent(ChangeLanguageIntent('ar')),
      expect: () => [
        const ProfileSuccess(
          name: 'Ahmed',
          email: 'ahmed@example.com',
          photoUrl: 'photo_url',
          languageCode: 'ar',
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [LogoutLoading, LogoutSuccess] and preserves language code when LogoutIntent is triggered',
      build: () {
        when(
          mockSecureStorage.read(key: ApiParam.languageCode),
        ).thenAnswer((_) async => 'ar');
        when(mockSecureStorage.deleteAll()).thenAnswer((_) async => {});
        when(
          mockSecureStorage.write(key: ApiParam.languageCode, value: 'ar'),
        ).thenAnswer((_) async => {});
        return profileCubit;
      },
      act: (cubit) => cubit.doIntent(LogoutIntent()),
      expect: () => [const LogoutLoading(), const LogoutSuccess()],
      verify: (_) {
        verify(mockSecureStorage.deleteAll()).called(1);
        verify(
          mockSecureStorage.write(key: ApiParam.languageCode, value: 'ar'),
        ).called(1);
      },
    );
  });
}
