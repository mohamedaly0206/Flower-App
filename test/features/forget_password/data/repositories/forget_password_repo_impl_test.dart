import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/forget_password/data/data_sources/forget_password_remote_data_source_contract.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/data/models/responses/enter_reset_email_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/reset_password_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/verify_reset_code_dto.dart';
import 'package:flower_app/features/forget_password/data/repositories/forget_password_repo_impl.dart';
import 'package:flower_app/features/forget_password/domain/entities/enter_reset_email_entity.dart';
import 'package:flower_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:flower_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate Mock for the Contract
@GenerateMocks([ForgetPasswordRemoteDataSourceContract])
import 'forget_password_repo_impl_test.mocks.dart';

void main() {
  late ForgetPasswordRepoImpl repository;
  late MockForgetPasswordRemoteDataSourceContract mockDataSource;

  setUpAll(() {
    // FIX: Provide dummy values for Mockito's internal fallback logic
    provideDummy<BaseResponse<EnterResetEmailDTO>>(
      SuccessBaseResponse<EnterResetEmailDTO>(
        data: EnterResetEmailDTO(message: '', info: ''),
      ),
    );
    provideDummy<BaseResponse<VerifyResetCodeDTO>>(
      SuccessBaseResponse<VerifyResetCodeDTO>(
        data: VerifyResetCodeDTO(status: ''),
      ),
    );
    provideDummy<BaseResponse<ResetPasswordDTO>>(
      SuccessBaseResponse<ResetPasswordDTO>(
        data: ResetPasswordDTO(message: '', token: ''),
      ),
    );
  });

  setUp(() {
    mockDataSource = MockForgetPasswordRemoteDataSourceContract();
    repository = ForgetPasswordRepoImpl(mockDataSource);
  });

  group('enterResetEmail', () {
    final tRequest = EnterResetEmailRequest(email: "test@example.com");
    final tDto = EnterResetEmailDTO(message: "Success", info: 'Some info');
    final tExpectedEntity = tDto.toDomain();

    test('should return SuccessBaseResponse with Entity when Data Source succeeds', () async {
      when(mockDataSource.enterResetEmail(any)).thenAnswer(
        (_) async => SuccessBaseResponse<EnterResetEmailDTO>(data: tDto),
      );

      final result = await repository.enterResetEmail(tRequest);

      expect(result, isA<SuccessBaseResponse<EnterResetEmailEntity>>());
      expect((result as SuccessBaseResponse).data, tExpectedEntity);
      verify(mockDataSource.enterResetEmail(tRequest)).called(1);
    });

    test('should return ErrorBaseResponse when Data Source fails', () async {
      const tError = "Server Error";
      when(mockDataSource.enterResetEmail(any)).thenAnswer(
        (_) async => ErrorBaseResponse<EnterResetEmailDTO>(errorMessage: tError),
      );

      final result = await repository.enterResetEmail(tRequest);

      expect(result, isA<ErrorBaseResponse<EnterResetEmailEntity>>());
      expect((result as ErrorBaseResponse).errorMessage, tError);
    });
  });

  group('verifyResetCode', () {
    final tRequest = VerifyResetCodeRequest(code: "1234");
    final tDto = VerifyResetCodeDTO(status: "Verified");
    final tExpectedEntity = tDto.toDomain();

    test('should return SuccessBaseResponse with Entity when code is verified', () async {
      when(mockDataSource.verifyResetCode(any)).thenAnswer(
        (_) async => SuccessBaseResponse<VerifyResetCodeDTO>(data: tDto),
      );

      final result = await repository.verifyResetCode(tRequest);

      expect(result, isA<SuccessBaseResponse<VerifyResetCodeEntity>>());
      expect((result as SuccessBaseResponse).data, tExpectedEntity);
    });

    test('should return ErrorBaseResponse when code verification fails', () async {
      when(mockDataSource.verifyResetCode(any)).thenAnswer(
        (_) async => ErrorBaseResponse<VerifyResetCodeDTO>(errorMessage: 'Invalid Code'),
      );

      final result = await repository.verifyResetCode(tRequest);

      expect(result, isA<ErrorBaseResponse<VerifyResetCodeEntity>>());
      expect((result as ErrorBaseResponse).errorMessage, 'Invalid Code');
    });
  });

  group('resetPassword', () {
    final tRequest = ResetPasswordRequest(email: "a@b.com", newPassword: "123");
    final tDto = ResetPasswordDTO(token: "token", message: 'Success');
    final tExpectedEntity = tDto.toDomain();

    test('should return SuccessBaseResponse with Entity when password is reset', () async {
      when(mockDataSource.resetPassword(any)).thenAnswer(
        (_) async => SuccessBaseResponse<ResetPasswordDTO>(data: tDto),
      );

      final result = await repository.resetPassword(tRequest);

      expect(result, isA<SuccessBaseResponse<ResetPasswordEntity>>());
      expect((result as SuccessBaseResponse).data, tExpectedEntity);
    });

    test('should return ErrorBaseResponse when password reset fails', () async {
      when(mockDataSource.resetPassword(any)).thenAnswer(
        (_) async => ErrorBaseResponse<ResetPasswordDTO>(errorMessage: 'Weak Password'),
      );

      final result = await repository.resetPassword(tRequest);

      expect(result, isA<ErrorBaseResponse<ResetPasswordEntity>>());
      expect((result as ErrorBaseResponse).errorMessage, 'Weak Password');
    });
  });
}