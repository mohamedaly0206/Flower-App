import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';

sealed class ForgetPasswordIntent {}

class EnterResetEmailIntent extends ForgetPasswordIntent {
  final EnterResetEmailRequest request;
  EnterResetEmailIntent(this.request);
}

class VerifyResetCodeIntent extends ForgetPasswordIntent {
  final VerifyResetCodeRequest request;
  VerifyResetCodeIntent(this.request);
}

class ResetPasswordIntent extends ForgetPasswordIntent {
  final ResetPasswordRequest request;
  ResetPasswordIntent(this.request);
}
