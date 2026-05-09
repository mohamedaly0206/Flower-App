import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/feature/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/feature/auth/login/domain/repo/login_repository.dart';
import 'package:flower_app/feature/auth/login/domain/use_case/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLoginRepository implements LoginRepository {
  String? receivedEmail;
  String? receivedPassword;
  late BaseResponse<LoginResponse> response;

  @override
  Future<BaseResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    receivedEmail = email;
    receivedPassword = password;
    return response;
  }
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
      );

      expect(result, same(repository.response));
      expect(repository.receivedEmail, 'user@mail.com');
      expect(repository.receivedPassword, 'password123');
    });
  });
}
