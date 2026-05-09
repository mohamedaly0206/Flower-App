import 'package:flower_app/features/auth/signup/domain/model/user_entity.dart';

class RegisterDetails {
  final String message;
  final String token;
  final UserEntity user;

  const RegisterDetails({
    required this.message,
    required this.token,
    required this.user,
  });
}
