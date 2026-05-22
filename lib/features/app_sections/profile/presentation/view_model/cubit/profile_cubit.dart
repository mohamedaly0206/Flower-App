import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/intent/profile_intent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../state/profile_states.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final FlutterSecureStorage _secureStorage;

  ProfileCubit(this._secureStorage) : super(const ProfileInitial());

  Future<void> doIntent(ProfileIntent intent) async {
    switch (intent) {
      case LoadUserProfileIntent():
        await loadUserProfile();
      case ChangeLanguageIntent():
        await changeLanguage(intent.languageCode);
      case LogoutIntent():
        await logout();
    }
  }

  Future<void> loadUserProfile() async {
    emit(const ProfileLoading());
    try {
      final name = await _secureStorage.read(key: ApiParam.userName) ?? 'User';
      final email = await _secureStorage.read(key: ApiParam.userEmail) ?? '';
      final photo = await _secureStorage.read(key: ApiParam.userPhoto) ?? '';
      final languageCode =
          await _secureStorage.read(key: ApiParam.languageCode) ?? 'en';

      emit(
        ProfileSuccess(
          name: name.isEmpty ? 'User' : name,
          email: email,
          photoUrl: photo,
          languageCode: languageCode == 'ar' ? 'ar' : 'en',
        ),
      );
    } catch (e) {
      emit(const ProfileError('Failed to load profile data'));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    final normalizedLanguageCode = languageCode == 'ar' ? 'ar' : 'en';
    await _secureStorage.write(
      key: ApiParam.languageCode,
      value: normalizedLanguageCode,
    );

    final currentState = state;
    if (currentState is ProfileSuccess) {
      emit(
        ProfileSuccess(
          name: currentState.name,
          email: currentState.email,
          photoUrl: currentState.photoUrl,
          languageCode: normalizedLanguageCode,
        ),
      );
    }
  }

  Future<void> logout() async {
    emit(const LogoutLoading());
    try {
      final languageCode =
          await _secureStorage.read(key: ApiParam.languageCode) ?? 'en';
      await _secureStorage.deleteAll();
      await _secureStorage.write(
        key: ApiParam.languageCode,
        value: languageCode == 'ar' ? 'ar' : 'en',
      );
      emit(const LogoutSuccess());
    } catch (e) {
      emit(const ProfileError('Logout failed, please try again'));
    }
  }
}
