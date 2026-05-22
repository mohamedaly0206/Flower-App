import 'package:flower_app/config/base_response/base_response.dart';
<<<<<<< HEAD
import 'package:flower_app/core/values/app_strings.dart';
=======
import 'package:flower_app/core/router/app_router.dart';

<<<<<<< HEAD
>>>>>>> origin/feature/change-password
=======
>>>>>>> origin/feature/cart
import 'package:flower_app/features/auth/login/data/data_sources/login_local_data_source.dart';
import 'package:flower_app/features/auth/login/data/data_sources/login_remote_data_source.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/features/auth/login/data/models/user_dto.dart';
import 'package:flower_app/features/auth/login/data/repo/login_repository_impl.dart';
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

class _FakeLoginLocalDataSource implements LoginLocalDataSource {
  String? receivedToken;
  bool rememberMe = false;
  bool didClearToken = false;
  Map<String, dynamic>? cachedUserData;

  @override
  Future<void> saveToken(String token) async {
    receivedToken = token;
  }

  @override
  Future<void> clearToken() async {
    receivedToken = null;
    didClearToken = true;
  }

  @override
  Future<void> saveRememberMe(bool rememberMe) async {
    this.rememberMe = rememberMe;
  }

  @override
  Future<bool> getRememberMe() async => rememberMe;

  @override
  Future<void> cacheUserData(Map<String, dynamic> userJson) async {
    cachedUserData = userJson;
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
        final localDataSource = _FakeLoginLocalDataSource();
        final repository = LoginRepositoryImpl(
          remoteDataSource,
          localDataSource,
        );

        final result = await repository.login(
          email: 'user@mail.com',
          password: 'password123',
          rememberMe: true,
        );

        expect(remoteDataSource.receivedEmail, 'user@mail.com');
        expect(remoteDataSource.receivedPassword, 'password123');
        expect(result, isA<SuccessBaseResponse<LoginResponse>>());
        expect(
          (result as SuccessBaseResponse<LoginResponse>).data,
          loginResponse,
        );
        expect(localDataSource.receivedToken, 'token');
        expect(localDataSource.rememberMe, isTrue);
      },
    );

    test('caches user data on successful login', () async {
      final loginResponse = LoginResponse(
        message: 'success',
        token: 'token',
        user: UserDTO(
          email: 'test@mail.com',
          firstName: 'Ahmed',
          photo: 'photo_url',
        ),
      );
      final remoteDataSource = _FakeLoginRemoteDataSource()
        ..response = loginResponse;
      final localDataSource = _FakeLoginLocalDataSource();
      final repository = LoginRepositoryImpl(remoteDataSource, localDataSource);

      await repository.login(
        email: 'test@mail.com',
        password: 'password123',
        rememberMe: true,
      );

      expect(localDataSource.cachedUserData, {
        'user_email': 'test@mail.com',
        'user_name': 'Ahmed',
        'user_photo': 'photo_url',
      });
    });

    test('stores token even when remember me is false', () async {
      final loginResponse = LoginResponse(message: 'success', token: 'token');
      final remoteDataSource = _FakeLoginRemoteDataSource()
        ..response = loginResponse;
      final localDataSource = _FakeLoginLocalDataSource();
      final repository = LoginRepositoryImpl(remoteDataSource, localDataSource);

      final result = await repository.login(
        email: 'user@mail.com',
        password: 'password123',
        rememberMe: false,
      );

      expect(result, isA<SuccessBaseResponse<LoginResponse>>());
      expect(localDataSource.receivedToken, 'token');
      expect(localDataSource.didClearToken, isFalse);
      expect(localDataSource.rememberMe, isFalse);
    });

    test('caches fallback profile data when user is missing', () async {
      final loginResponse = LoginResponse(message: 'success', token: 'token');
      final remoteDataSource = _FakeLoginRemoteDataSource()
        ..response = loginResponse;
      final localDataSource = _FakeLoginLocalDataSource();
      final repository = LoginRepositoryImpl(remoteDataSource, localDataSource);

      final result = await repository.login(
        email: 'user@mail.com',
        password: 'password123',
        rememberMe: true,
      );

      expect(result, isA<SuccessBaseResponse<LoginResponse>>());
      expect(localDataSource.cachedUserData, {
        'user_email': 'user@mail.com',
        'user_name': 'user',
        'user_photo': '',
      });
    });

    test('returns error response when remote data source throws', () async {
      final remoteDataSource = _FakeLoginRemoteDataSource()
        ..error = Exception('network error');
      final localDataSource = _FakeLoginLocalDataSource();
      final repository = LoginRepositoryImpl(remoteDataSource, localDataSource);

      final result = await repository.login(
        email: 'user@mail.com',
        password: 'password123',
        rememberMe: false,
      );

      expect(result, isA<ErrorBaseResponse<LoginResponse>>());
      expect(
        (result as ErrorBaseResponse<LoginResponse>).errorMessage,
        AppStrings.errorMessage,
      );
      expect(localDataSource.receivedToken, isNull);
    });

    test('returns error response when login token is missing', () async {
      final remoteDataSource = _FakeLoginRemoteDataSource()
        ..response = LoginResponse(message: 'success');
      final localDataSource = _FakeLoginLocalDataSource();
      final repository = LoginRepositoryImpl(remoteDataSource, localDataSource);

      final result = await repository.login(
        email: 'user@mail.com',
        password: 'password123',
        rememberMe: false,
      );

      expect(result, isA<ErrorBaseResponse<LoginResponse>>());
      expect(
        (result as ErrorBaseResponse<LoginResponse>).errorMessage,
        AppStrings.cacheStorageError,
      );
      expect(localDataSource.receivedToken, isNull);
    });
  });
}
