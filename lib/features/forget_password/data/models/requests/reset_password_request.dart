import 'package:flower_app/core/values/api_param.dart';

class ResetPasswordRequest {
  final String email;
  final String newPassword;

  ResetPasswordRequest({required this.email, required this.newPassword});
  Map<String, dynamic> toJson() {
    return {ApiParam.email: email, ApiParam.newPassword: newPassword};
  }
}
