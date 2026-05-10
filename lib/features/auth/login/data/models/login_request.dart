import 'package:flower_app/core/values/api_param.dart';

class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {ApiParam.email: email, ApiParam.password: password};
  }
}
