import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/features/auth/login/domain/repo/login_repository.dart';
import 'package:flower_app/features/auth/login/domain/use_case/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLoginRepository implements LoginRepository {
  String? receivedEmail;
  String? receivedPassword;
  bool? receivedRememberMe;
  bool rememberMe = false;
  late BaseResponse<LoginResponse> response;

  @override
  Future<BaseResponse<LoginResponse>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    receivedEmail = email;
    receivedPassword = password;
    receivedRememberMe = rememberMe;
    return response;
  }

  @override
  Future<bool> getRememberMe() async => rememberMe;
}

void main() {
  group('LoginUseCase', () {
    test('forwards email and password to repository', () async {
      final loginResponse = LoginResponse(message: 'success', token: 'token');
      final repository = _FakeLoginRepository()
        ..response = SuccessBaseResponse(data: loginResponse);
      final useCase = LoginUseCase(repository);

      final result = await useCase(
        email: 'user@mail.com',
        password: 'password123',
        rememberMe: true,
      );

      expect(result, same(repository.response));
      expect(repository.receivedEmail, 'user@mail.com');
      expect(repository.receivedPassword, 'password123');
      expect(repository.receivedRememberMe, isTrue);
    });

    test('forwards remember me reads to repository', () async {
      final repository = _FakeLoginRepository()..rememberMe = true;
      final useCase = LoginUseCase(repository);

      expect(await useCase.getRememberMe(), isTrue);
    });
  });
}
