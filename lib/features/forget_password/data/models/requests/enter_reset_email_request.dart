import 'package:flower_app/core/values/api_param.dart';

class EnterResetEmailRequest {
  final String email;

  EnterResetEmailRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {ApiParam.email: email};
  }
}
