import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/edit_profile/domain/entities/user_profile_entity.dart';

enum EditProfileStatus { initial, loading, success, error, imageUploading }

class EditProfileState extends Equatable {
  final EditProfileStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final String? successMessage;
  final File? localPhotoFile;

  const EditProfileState({
    this.status = EditProfileStatus.initial,
    this.user,
    this.errorMessage,
    this.successMessage,
    this.localPhotoFile,
  });

  EditProfileState copyWith({
    EditProfileStatus? status,
    UserEntity? user,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    File? localPhotoFile,
    bool clearLocalPhotoFile = false,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccessMessage
          ? null
          : (successMessage ?? this.successMessage),
      localPhotoFile: clearLocalPhotoFile
          ? null
          : (localPhotoFile ?? this.localPhotoFile),
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
    errorMessage,
    successMessage,
    localPhotoFile,
  ];
}
