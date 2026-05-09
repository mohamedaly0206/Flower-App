import 'package:flower_app/core/values/api_param.dart';

class VerifyResetCodeRequest {
  final String code;

  VerifyResetCodeRequest({required this.code});
  Map<String, dynamic> toJson() {
    return {ApiParam.resetCode: code};
  }
}
