import 'dart:async';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/features/auth/login/domain/repo/login_repository.dart';
import 'package:flower_app/features/auth/login/domain/use_case/login_use_case.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/state/login_states.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLoginRepository implements LoginRepository {
  String? receivedEmail;
  String? receivedPassword;
  bool? receivedRememberMe;
  bool rememberMe = false;
  int callsCount = 0;
  BaseResponse<LoginResponse>? response;
  Completer<BaseResponse<LoginResponse>>? completer;

  @override
  Future<BaseResponse<LoginResponse>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    callsCount++;
    receivedEmail = email;
    receivedPassword = password;
    receivedRememberMe = rememberMe;

    final completer = this.completer;
    if (completer != null) {
      return completer.future;
    }

    return Future.value(response!);
  }

  @override
  Future<bool> getRememberMe() async => rememberMe;
}

void main() {
  group('LoginCubit', () {
    late _FakeLoginRepository repository;
    late LoginCubit cubit;

    setUp(() {
      repository = _FakeLoginRepository();
      cubit = LoginCubit(LoginUseCase(repository), FlutterSecureStorage());
    });

    tearDown(() async {
      await cubit.close();
    });

    test('starts with initial state', () {
      expect(cubit.state, const LoginInitial());
    });

    test('toggles password visibility', () async {
      final emittedStates = <LoginState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      cubit.togglePasswordVisibility();
      cubit.togglePasswordVisibility();
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();

      expect(emittedStates, [
        const LoginInitial(obscurePassword: false),
        const LoginInitial(),
      ]);
    });

    test('loads remember me', () async {
      repository.rememberMe = true;
      final emittedStates = <LoginState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      await cubit.loadRememberMe();
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();

      expect(emittedStates, [const LoginInitial(rememberMe: true)]);
    });

    test('toggles remember me', () async {
      final emittedStates = <LoginState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      cubit.toggleRememberMe(true);
      cubit.toggleRememberMe(false);
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();

      expect(emittedStates, [
        const LoginInitial(rememberMe: true),
        const LoginInitial(),
      ]);
    });

    test('emits loading then data state on successful login', () async {
      final loginResponse = LoginResponse(message: 'success', token: 'token');
      repository.response = SuccessBaseResponse(data: loginResponse);
      final emittedStates = <LoginState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      await cubit.login(email: 'user@mail.com', password: 'password123');
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();

      expect(repository.receivedEmail, 'user@mail.com');
      expect(repository.receivedPassword, 'password123');
      expect(repository.receivedRememberMe, isFalse);
      expect(emittedStates, [
        const LoginLoading(),
        LoginSuccess(loginResponse),
      ]);
    });

    test('passes remember me to repository on successful login', () async {
      final loginResponse = LoginResponse(message: 'success', token: 'token');
      repository.response = SuccessBaseResponse(data: loginResponse);
      final emittedStates = <LoginState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      cubit.toggleRememberMe(true);
      await cubit.login(email: 'user@mail.com', password: 'password123');
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();

      expect(repository.receivedRememberMe, isTrue);
      expect(emittedStates, [
        const LoginInitial(rememberMe: true),
        const LoginLoading(rememberMe: true),
        LoginSuccess(loginResponse, rememberMe: true),
      ]);
    });

    test('emits loading then error state on failed login', () async {
      repository.response = ErrorBaseResponse(errorMessage: 'invalid login');
      final emittedStates = <LoginState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      await cubit.login(email: 'user@mail.com', password: 'wrongPassword');
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();

      expect(emittedStates, [
        const LoginLoading(),
        const LoginFailure('invalid login'),
      ]);
    });

    test('ignores login requests while loading', () async {
      repository.completer = Completer<BaseResponse<LoginResponse>>();

      final firstLogin = cubit.login(
        email: 'user@mail.com',
        password: 'password123',
      );
      await Future<void>.delayed(Duration.zero);

      await cubit.login(email: 'second@mail.com', password: 'password456');

      expect(repository.callsCount, 1);
      expect(repository.receivedEmail, 'user@mail.com');

      repository.completer!.complete(
        SuccessBaseResponse(data: LoginResponse(token: 'token')),
      );
      await firstLogin;
    });
  });
}
