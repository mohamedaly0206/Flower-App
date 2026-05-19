import 'package:flower_app/core/values/api_param.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'profile_states.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final FlutterSecureStorage _secureStorage;

  ProfileCubit(this._secureStorage) : super(const ProfileInitial());

  Future<void> loadUserProfile() async {
    emit(const ProfileLoading());
    try {
      final name = await _secureStorage.read(key: ApiParam.userName) ?? 'User';
      final email = await _secureStorage.read(key: ApiParam.userEmail) ?? '';
      final photo = await _secureStorage.read(key: ApiParam.userPhoto) ?? '';

      if (!isClosed) {
        emit(
          ProfileSuccess(
            name: name.isEmpty ? 'User' : name,
            email: email,
            photoUrl: photo,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(const ProfileError('Failed to load profile data'));
      }
    }
  }

  Future<void> logout() async {
    emit(const LogoutLoading());
    try {
      await _secureStorage.deleteAll();

      if (!isClosed) {
        emit(const LogoutSuccess());
      }
    } catch (e) {
      if (!isClosed) {
        emit(const ProfileError('Logout failed, please try again'));
      }
    }
  }
}
