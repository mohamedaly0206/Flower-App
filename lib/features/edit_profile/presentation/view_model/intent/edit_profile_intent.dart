import 'dart:io';
import 'package:equatable/equatable.dart';

sealed class EditeProfileIntent extends Equatable {
  const EditeProfileIntent();

  @override
  List<Object?> get props => [];
}

class FetchProfileIntent extends EditeProfileIntent {
  const FetchProfileIntent();
}

class UpdateFirstNameIntent extends EditeProfileIntent {
  final String firstName;
  const UpdateFirstNameIntent(this.firstName);

  @override
  List<Object?> get props => [firstName];
}

class UpdateLastNameIntent extends EditeProfileIntent {
  final String lastName;
  const UpdateLastNameIntent(this.lastName);

  @override
  List<Object?> get props => [lastName];
}

class UpdatePhoneIntent extends EditeProfileIntent {
  final String phone;
  const UpdatePhoneIntent(this.phone);

  @override
  List<Object?> get props => [phone];
}

class UpdateEmailIntent extends EditeProfileIntent {
  final String email;
  const UpdateEmailIntent(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdateGenderIntent extends EditeProfileIntent {
  final String gender;
  const UpdateGenderIntent(this.gender);

  @override
  List<Object?> get props => [gender];
}

class UploadPhotoIntent extends EditeProfileIntent {
  final File file;
  const UploadPhotoIntent(this.file);

  @override
  List<Object?> get props => [file];
}

class SubmitProfileUpdateIntent extends EditeProfileIntent {
  const SubmitProfileUpdateIntent();
}
