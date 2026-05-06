import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/security_storage/security_storage.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/feature/auth/login/data/data_sources/login_remote_data_source.dart';
import 'package:flower_app/feature/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/feature/auth/login/data/repo/login_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLoginRemoteDataSource implements LoginRemoteDataSource {
  String? receivedEmail;
  String? receivedPassword;
  LoginResponse? response;
  Object? error;

  @override
  Future<LoginResponse> login(String email, String password) async {
    receivedEmail = email;
    receivedPassword = password;

    final error = this.error;
    if (error != null) {
      throw error;
    }

    return response!;
  }
}

class _FakeSecurityStorage extends SecurityStorage {
  String? receivedKey;
  String? receivedValue;

  _FakeSecurityStorage() : super(const FlutterSecureStorage());

  @override
  Future<void> setSecuredString(String key, String value) async {
    receivedKey = key;
    receivedValue = value;
  }
}

void main() {
  group('LoginRepositoryImpl', () {
    test(
      'returns success response and stores token on successful login',
      () async {
        final loginResponse = LoginResponse(message: 'success', token: 'token');
        final remoteDataSource = _FakeLoginRemoteDataSource()
          ..response = loginResponse;
        final securityStorage = _FakeSecurityStorage();
        final repository = LoginRepositoryImpl(
          remoteDataSource,
          securityStorage,
        );

        final result = await repository.login(
          email: 'user@mail.com',
          password: 'password123',
        );

        expect(remoteDataSource.receivedEmail, 'user@mail.com');
        expect(remoteDataSource.receivedPassword, 'password123');
        expect(result, isA<SuccessBaseResponse<LoginResponse>>());
        expect(
          (result as SuccessBaseResponse<LoginResponse>).data,
          loginResponse,
        );
        expect(securityStorage.receivedKey, ApiParam.token);
        expect(securityStorage.receivedValue, 'token');
      },
    );

    test('returns error response when remote data source throws', () async {
      final remoteDataSource = _FakeLoginRemoteDataSource()
        ..error = Exception('network error');
      final securityStorage = _FakeSecurityStorage();
      final repository = LoginRepositoryImpl(remoteDataSource, securityStorage);

      final result = await repository.login(
        email: 'user@mail.com',
        password: 'password123',
      );

      expect(result, isA<ErrorBaseResponse<LoginResponse>>());
      expect(
        (result as ErrorBaseResponse<LoginResponse>).errorMessage,
        AppStrings.errorMessage,
      );
      expect(securityStorage.receivedKey, isNull);
      expect(securityStorage.receivedValue, isNull);
    });
  });
}
