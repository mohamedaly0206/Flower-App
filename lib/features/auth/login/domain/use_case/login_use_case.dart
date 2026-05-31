import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/features/auth/login/domain/repo/login_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  Future<BaseResponse<LoginResponse>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    return _loginRepository.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }

  Future<bool> getRememberMe() {
    return _loginRepository.getRememberMe();
  }
}
