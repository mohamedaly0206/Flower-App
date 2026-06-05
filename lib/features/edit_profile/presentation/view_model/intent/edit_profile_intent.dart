import 'dart:io';
import 'package:equatable/equatable.dart';

sealed class EditProfileIntent extends Equatable {
  const EditProfileIntent();

  @override
  List<Object?> get props => [];
}

class FetchProfileIntent extends EditProfileIntent {
  const FetchProfileIntent();
}

class UpdateFirstNameIntent extends EditProfileIntent {
  final String firstName;
  const UpdateFirstNameIntent(this.firstName);

  @override
  List<Object?> get props => [firstName];
}

class UpdateLastNameIntent extends EditProfileIntent {
  final String lastName;
  const UpdateLastNameIntent(this.lastName);

  @override
  List<Object?> get props => [lastName];
}

class UpdatePhoneIntent extends EditProfileIntent {
  final String phone;
  const UpdatePhoneIntent(this.phone);

  @override
  List<Object?> get props => [phone];
}

class UpdateEmailIntent extends EditProfileIntent {
  final String email;
  const UpdateEmailIntent(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdateGenderIntent extends EditProfileIntent {
  final String gender;
  const UpdateGenderIntent(this.gender);

  @override
  List<Object?> get props => [gender];
}

class UploadPhotoIntent extends EditProfileIntent {
  final File file;
  const UploadPhotoIntent(this.file);

  @override
  List<Object?> get props => [file];
}

class SubmitProfileUpdateIntent extends EditProfileIntent {
  const SubmitProfileUpdateIntent();
}
