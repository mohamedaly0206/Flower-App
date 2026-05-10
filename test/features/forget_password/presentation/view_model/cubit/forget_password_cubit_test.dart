import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/auth/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/enter_reset_email_entity.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/reset_password_entity.dart';
import 'package:flower_app/features/auth/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:flower_app/features/auth/forget_password/domain/use_cases/enter_reset_email_use_case.dart';
import 'package:flower_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flower_app/features/auth/forget_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/auth/forget_password/presentation/view_model/intent/forget_password_intent.dart';

@GenerateMocks([
  EnterResetEmailUseCase,
  VerifyResetCodeUseCase,
  ResetPasswordUseCase,
])
import 'forget_password_cubit_test.mocks.dart';

void main() {
  late MockEnterResetEmailUseCase mockEnterEmailUseCase;
  late MockVerifyResetCodeUseCase mockVerifyCodeUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;

  setUpAll(() {
    provideDummy<BaseResponse<EnterResetEmailEntity>>(
      SuccessBaseResponse<EnterResetEmailEntity>(
        data: const EnterResetEmailEntity(message: '', info: ''),
      ),
    );
    provideDummy<BaseResponse<VerifyResetCodeEntity>>(
      SuccessBaseResponse<VerifyResetCodeEntity>(
        data: const VerifyResetCodeEntity(status: ''),
      ),
    );
    provideDummy<BaseResponse<ResetPasswordEntity>>(
      SuccessBaseResponse<ResetPasswordEntity>(
        data: const ResetPasswordEntity(token: '', message: ''),
      ),
    );
  });

  setUp(() {
    mockEnterEmailUseCase = MockEnterResetEmailUseCase();
    mockVerifyCodeUseCase = MockVerifyResetCodeUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
  });

  group('ForgetPasswordCubit - EnterEmail', () {
    final tRequest = EnterResetEmailRequest(email: 'test@example.com');
    const tEntity = EnterResetEmailEntity(message: 'Success', info: '');

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success, updateEmail] when EnterResetEmailIntent is successful',
      setUp: () {
        when(mockEnterEmailUseCase.call(any)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<EnterResetEmailEntity>(data: tEntity),
        );
      },
      build: () => ForgetPasswordCubit(
        mockEnterEmailUseCase,
        mockResetPasswordUseCase,
        mockVerifyCodeUseCase,
      ),
      act: (cubit) => cubit.doIntent(EnterResetEmailIntent(tRequest)),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.enterEmailState.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.enterEmailState.data,
          'data',
          tEntity,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.email,
          'email',
          'test@example.com',
        ),
      ],
      verify: (_) {
        verify(mockEnterEmailUseCase.call(tRequest)).called(1);
      },
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when EnterResetEmailIntent fails',
      setUp: () {
        when(mockEnterEmailUseCase.call(any)).thenAnswer(
          (_) async => ErrorBaseResponse<EnterResetEmailEntity>(
            errorMessage: 'Invalid Email',
          ),
        );
      },
      build: () => ForgetPasswordCubit(
        mockEnterEmailUseCase,
        mockResetPasswordUseCase,
        mockVerifyCodeUseCase,
      ),
      act: (cubit) => cubit.doIntent(EnterResetEmailIntent(tRequest)),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.enterEmailState.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.enterEmailState.errorMessage,
          'errorMessage',
          'Invalid Email',
        ),
      ],
    );
  });

  group('ForgetPasswordCubit - VerifyResetCode', () {
    final tRequest = VerifyResetCodeRequest(code: '123456');
    const tEntity = VerifyResetCodeEntity(status: 'Verified');

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when VerifyResetCodeIntent is successful',
      setUp: () {
        when(mockVerifyCodeUseCase.call(any)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<VerifyResetCodeEntity>(data: tEntity),
        );
      },
      build: () => ForgetPasswordCubit(
        mockEnterEmailUseCase,
        mockResetPasswordUseCase,
        mockVerifyCodeUseCase,
      ),
      act: (cubit) => cubit.doIntent(VerifyResetCodeIntent(tRequest)),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.verifyResetCodeState.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.verifyResetCodeState.data,
          'data',
          tEntity,
        ),
      ],
    );
  });

  group('ForgetPasswordCubit - ResetPassword', () {
    final tRequest = ResetPasswordRequest(
      email: 'test@example.com',
      newPassword: 'password123',
    );
    const tEntity = ResetPasswordEntity(token: 'new_token', message: '');

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when ResetPasswordIntent is successful',
      setUp: () {
        when(mockResetPasswordUseCase.call(any)).thenAnswer(
          (_) async => SuccessBaseResponse<ResetPasswordEntity>(data: tEntity),
        );
      },
      build: () => ForgetPasswordCubit(
        mockEnterEmailUseCase,
        mockResetPasswordUseCase,
        mockVerifyCodeUseCase,
      ),
      act: (cubit) => cubit.doIntent(ResetPasswordIntent(tRequest)),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.resetPasswordState.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.resetPasswordState.data,
          'data',
          tEntity,
        ),
      ],
    );
  });
}
