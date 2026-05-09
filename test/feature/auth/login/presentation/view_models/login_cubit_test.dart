import 'dart:async';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/features/auth/login/domain/repo/login_repository.dart';
import 'package:flower_app/features/auth/login/domain/use_case/login_use_case.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/login_states.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLoginRepository implements LoginRepository {
  String? receivedEmail;
  String? receivedPassword;
  int callsCount = 0;
  BaseResponse<LoginResponse>? response;
  Completer<BaseResponse<LoginResponse>>? completer;

  @override
  Future<BaseResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) {
    callsCount++;
    receivedEmail = email;
    receivedPassword = password;

    final completer = this.completer;
    if (completer != null) {
      return completer.future;
    }

    return Future.value(response);
  }
}

void main() {
  group('LoginCubit', () {
    late _FakeLoginRepository repository;
    late LoginCubit cubit;

    setUp(() {
      repository = _FakeLoginRepository();
      cubit = LoginCubit(LoginUseCase(repository));
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
      expect(emittedStates, [
        const LoginLoading(),
        LoginSuccess(loginResponse),
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
