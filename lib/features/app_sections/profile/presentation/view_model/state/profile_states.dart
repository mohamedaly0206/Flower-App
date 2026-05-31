import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  final String name;
  final String email;
  final String photoUrl;
  final String languageCode;

  const ProfileSuccess({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.languageCode,
  });

  @override
  List<Object?> get props => [name, email, photoUrl, languageCode];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutLoading extends ProfileState {
  const LogoutLoading();
}

class LogoutSuccess extends ProfileState {
  const LogoutSuccess();
}
