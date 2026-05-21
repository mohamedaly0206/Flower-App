import 'package:meta/meta.dart';

@immutable
sealed class ChangePasswordIntent {}

class ExecuteChangePasswordIntent extends ChangePasswordIntent {
  final String oldPassword;
  final String newPassword;

  ExecuteChangePasswordIntent({
    required this.oldPassword,
    required this.newPassword,
  });
}
