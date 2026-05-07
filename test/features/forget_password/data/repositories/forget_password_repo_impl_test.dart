import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/forget_password/data/data_sources/forget_password_remote_data_source_contract.dart';
import 'package:flower_app/features/forget_password/data/repositories/forget_password_repo_impl.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/data/models/responses/enter_reset_email_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/reset_password_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/verify_reset_code_dto.dart';
import 'package:flower_app/features/forget_password/domain/entities/enter_reset_email_entity.dart';
import 'package:flower_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:flower_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';

import 'forget_password_repo_impl_test.mocks.dart';

@GenerateMocks([
  ForgetPasswordRemoteDataSourceContract,
  EnterResetEmailDTO,
  VerifyResetCodeDTO,
  ResetPasswordDTO,
])
void main() {
  late ForgetPasswordRepoImpl repository;
  late MockForgetPasswordRemoteDataSourceContract mockDataSource;

  setUpAll(() {
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

    mockDataSource = MockForgetPasswordRemoteDataSourceContract();
    repository = ForgetPasswordRepoImpl(mockDataSource);
  });

  group('enterResetEmail', () {
    final tRequest = EnterResetEmailRequest(email: "test@example.com");
    final tDto = MockEnterResetEmailDTO();
    final tEntity = EnterResetEmailEntity(message: "Success", info: '');

    test(
      'should return SuccessBaseResponse with Entity when Data Source succeeds',
      () async {
        // Arrange
        when(tDto.toDomain()).thenReturn(tEntity);
        when(mockDataSource.enterResetEmail(any)).thenAnswer(
          (_) async => SuccessBaseResponse<EnterResetEmailDTO>(data: tDto),
        );

        // Act
        final result = await repository.enterResetEmail(tRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<EnterResetEmailEntity>>());
        expect((result as SuccessBaseResponse).data, tEntity);
        verify(mockDataSource.enterResetEmail(tRequest)).called(1);
      },
    );

    test('should return ErrorBaseResponse when Data Source fails', () async {
      // Arrange
      const tError = "Email not found";
      when(mockDataSource.enterResetEmail(any)).thenAnswer(
        (_) async =>
            ErrorBaseResponse<EnterResetEmailDTO>(errorMessage: tError),
      );

      // Act
      final result = await repository.enterResetEmail(tRequest);

      // Assert
      expect(result, isA<ErrorBaseResponse<EnterResetEmailEntity>>());
      expect((result as ErrorBaseResponse).errorMessage, tError);
    });
  });

  group('verifyResetCode', () {
    final tRequest = VerifyResetCodeRequest(code: "1234");
    final tDto = MockVerifyResetCodeDTO();
    final tEntity = VerifyResetCodeEntity(status: "Verified");

    test(
      'should return SuccessBaseResponse with Entity when code is verified',
      () async {
        // Arrange
        when(tDto.toDomain()).thenReturn(tEntity);
        when(mockDataSource.verifyResetCode(any)).thenAnswer(
          (_) async => SuccessBaseResponse<VerifyResetCodeDTO>(data: tDto),
        );

        // Act
        final result = await repository.verifyResetCode(tRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<VerifyResetCodeEntity>>());
        expect((result as SuccessBaseResponse).data, tEntity);
      },
    );
  });

  group('resetPassword', () {
    final tRequest = ResetPasswordRequest(email: "a@b.com", newPassword: "123");
    final tDto = MockResetPasswordDTO();
    final tEntity = ResetPasswordEntity(token: "token", message: '');

    test(
      'should return SuccessBaseResponse with Entity when password is reset',
      () async {
        // Arrange
        when(tDto.toDomain()).thenReturn(tEntity);
        when(mockDataSource.resetPassword(any)).thenAnswer(
          (_) async => SuccessBaseResponse<ResetPasswordDTO>(data: tDto),
        );

        // Act
        final result = await repository.resetPassword(tRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<ResetPasswordEntity>>());
        expect((result as SuccessBaseResponse).data, tEntity);
      },
    );
  });
}
