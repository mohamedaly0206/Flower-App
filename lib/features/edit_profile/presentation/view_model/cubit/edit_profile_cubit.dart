import 'dart:io';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/features/edit_profile/domain/entities/edit_profile_body.dart';
import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/get_profile_use_case.dart';
import 'package:flower_app/features/edit_profile/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/intent/edit_profile_intent.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/state/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final EditProfileUseCase _editProfileUseCase;
  final UploadProfilePhotoUseCase _uploadProfilePhotoUseCase;
  final FlutterSecureStorage _secureStorage;
  UserEntity? _baselineUser;

  EditProfileCubit(
    this._getProfileUseCase,
    this._editProfileUseCase,
    this._uploadProfilePhotoUseCase,
    this._secureStorage,
  ) : super(const EditProfileState());

  void handleIntent(EditeProfileIntent intent) {
    switch (intent) {
      case FetchProfileIntent():
        _fetchProfile();
      case UpdateFirstNameIntent():
        _updateFirstName(intent.firstName);
      case UpdateLastNameIntent():
        _updateLastName(intent.lastName);
      case UpdatePhoneIntent():
        _updatePhone(intent.phone);
      case UpdateEmailIntent():
        _updateEmail(intent.email);
      case UpdateGenderIntent():
        _updateGender(intent.gender);
      case UploadPhotoIntent():
        _uploadPhoto(intent.file);
      case SubmitProfileUpdateIntent():
        _submitProfile();
    }
  }

  Future<void> _fetchProfile() async {
    emit(
      state.copyWith(
        status: EditProfileStatus.loading,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
    final response = await _getProfileUseCase();

    switch (response) {
      case SuccessBaseResponse():
        final user = userWithNormalizedGender(response.data.user);
        _baselineUser = user;
        emit(
          state.copyWith(
            status: EditProfileStatus.success,
            user: user,
            clearErrorMessage: true,
            clearSuccessMessage: true,
            clearLocalPhotoFile: true,
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: EditProfileStatus.error,
            errorMessage: response.errorMessage,
            clearSuccessMessage: true,
          ),
        );
    }
  }

  void _updateFirstName(String firstName) {
    if (state.user != null) {
      emit(
        state.copyWith(
          user: state.user!.copyWith(firstName: firstName),
          clearErrorMessage: true,
        ),
      );
    }
  }

  void _updateLastName(String lastName) {
    if (state.user != null) {
      emit(
        state.copyWith(
          user: state.user!.copyWith(lastName: lastName),
          clearErrorMessage: true,
        ),
      );
    }
  }

  void _updatePhone(String phone) {
    if (state.user != null) {
      emit(
        state.copyWith(
          user: state.user!.copyWith(phone: phone),
          clearErrorMessage: true,
        ),
      );
    }
  }

  void _updateEmail(String email) {
    if (state.user != null) {
      emit(
        state.copyWith(
          user: state.user!.copyWith(email: email),
          clearErrorMessage: true,
        ),
      );
    }
  }

  void _updateGender(String gender) {
    final normalized = normalizeProfileGender(gender);
    if (state.user != null && normalized != null) {
      emit(
        state.copyWith(
          user: state.user!.copyWith(gender: normalized),
          clearErrorMessage: true,
        ),
      );
    }
  }

  Future<void> _uploadPhoto(File file) async {
    emit(
      state.copyWith(
        status: EditProfileStatus.imageUploading,
        localPhotoFile: file,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
    final response = await _uploadProfilePhotoUseCase(file);

    switch (response) {
      case SuccessBaseResponse():
        await _refetchProfileAfterMutation(
          successMessage: response.data.message ?? 'Photo updated successfully',
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: EditProfileStatus.error,
            errorMessage: response.errorMessage,
            clearSuccessMessage: true,
          ),
        );
    }
  }

  Future<void> _submitProfile() async {
    final user = state.user;
    if (user == null) {
      emit(
        state.copyWith(
          status: EditProfileStatus.error,
          errorMessage: 'Profile not loaded. Please try again.',
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    final email = user.email?.trim() ?? '';
    if (!isValidProfileEmail(email)) {
      emit(
        state.copyWith(
          status: EditProfileStatus.error,
          errorMessage: 'Please enter a valid email address',
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    final body = buildEditProfileBody(current: user, baseline: _baselineUser);
    if (body.isEmpty) {
      emit(
        state.copyWith(
          status: EditProfileStatus.error,
          errorMessage: 'No changes to save',
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: EditProfileStatus.loading,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
    final response = await _editProfileUseCase(body);

    switch (response) {
      case SuccessBaseResponse():
        final updatedUser = mergeEditProfileSuccessUser(
          localUser: user,
          responseUser: response.data.user,
          sentBody: body,
        );
        _baselineUser = updatedUser;
        await _cacheUserData(updatedUser);
        emit(
          state.copyWith(
            status: EditProfileStatus.success,
            user: updatedUser,
            successMessage:
                response.data.message ?? 'Profile updated successfully',
            clearErrorMessage: true,
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: EditProfileStatus.error,
            errorMessage: response.errorMessage,
            clearSuccessMessage: true,
          ),
        );
    }
  }

  /// upload-photo returns `{ "message": "success" }` only — refresh from GET.
  Future<void> _refetchProfileAfterMutation({
    required String successMessage,
  }) async {
    final response = await _getProfileUseCase();

    switch (response) {
      case SuccessBaseResponse():
        final user = userWithNormalizedGender(response.data.user);
        _baselineUser = user;
        await _cacheUserData(user);
        emit(
          state.copyWith(
            status: EditProfileStatus.success,
            user: user,
            successMessage: successMessage,
            clearErrorMessage: true,
            clearLocalPhotoFile: true,
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: EditProfileStatus.error,
            errorMessage: response.errorMessage,
            clearSuccessMessage: true,
          ),
        );
    }
  }

  Future<void> _cacheUserData(UserEntity? user) async {
    if (user == null) return;

    await _secureStorage.write(
      key: ApiParam.userName,
      value: user.firstName ?? 'User',
    );
    await _secureStorage.write(
      key: ApiParam.userEmail,
      value: user.email ?? '',
    );
    await _secureStorage.write(
      key: ApiParam.userPhoto,
      value: user.photo ?? '',
    );
  }
}
