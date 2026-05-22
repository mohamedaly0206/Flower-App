import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';

abstract class LoginRepository {
  Future<BaseResponse<LoginResponse>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });
  Future<bool> getRememberMe();
}
