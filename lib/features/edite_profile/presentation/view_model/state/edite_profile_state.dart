import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flower_app/features/edite_profile/domain/entities/user_profile_entity.dart';

enum EditeProfileStatus { initial, loading, success, error, imageUploading }

class EditeProfileState extends Equatable {
  final EditeProfileStatus status;
  final UserEntity? user;
  final String? errorMessage;
  final String? successMessage;
  final File? localPhotoFile;

  const EditeProfileState({
    this.status = EditeProfileStatus.initial,
    this.user,
    this.errorMessage,
    this.successMessage,
    this.localPhotoFile,
  });

  EditeProfileState copyWith({
    EditeProfileStatus? status,
    UserEntity? user,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    File? localPhotoFile,
    bool clearLocalPhotoFile = false,
  }) {
    return EditeProfileState(
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
