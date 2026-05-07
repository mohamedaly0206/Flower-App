import 'package:flower_app/features/forget_password/api/data_sources/forget_password_remot_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/data/models/responses/enter_reset_email_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/reset_password_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/verify_reset_code_dto.dart';

import 'forget_password_remot_data_source_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordApiClient])

void main() {
  late ForgetPasswordRemotDataSourceImpl dataSource;
  late MockForgetPasswordApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockForgetPasswordApiClient();
    dataSource = ForgetPasswordRemotDataSourceImpl(forgetPasswordApiClient: mockApiClient);
  });

  group('enterResetEmail', () {
    final tRequest = EnterResetEmailRequest(email: "test@example.com");
    final tResponseDTO = EnterResetEmailDTO(message: "Success", info: '');

    test('should return SuccessBaseResponse when API call is successful', () async {
      when(mockApiClient.enterResetEmail(any)).thenAnswer((_) async => tResponseDTO);

      final result = await dataSource.enterResetEmail(tRequest);

      expect(result, isA<SuccessBaseResponse<EnterResetEmailDTO>>());
      expect((result as SuccessBaseResponse).data, tResponseDTO);
      verify(mockApiClient.enterResetEmail(tRequest)).called(1);
    });

    test('should return ErrorBaseResponse when API call fails', () async {
      when(mockApiClient.enterResetEmail(any)).thenThrow(Exception("Network Error"));

      final result = await dataSource.enterResetEmail(tRequest);

      expect(result, isA<ErrorBaseResponse<EnterResetEmailDTO>>());
      verify(mockApiClient.enterResetEmail(tRequest)).called(1);
    });
  });

  group('verifyResetCode', () {
    final tRequest = VerifyResetCodeRequest( code: '',);
    final tResponseDTO = VerifyResetCodeDTO(status: "Verified");

    test('should return SuccessBaseResponse when code is valid', () async {
      when(mockApiClient.verifyResetCode(any)).thenAnswer((_) async => tResponseDTO);

      final result = await dataSource.verifyResetCode(tRequest);

      expect(result, isA<SuccessBaseResponse<VerifyResetCodeDTO>>());
      expect((result as SuccessBaseResponse).data, tResponseDTO);
      verify(mockApiClient.verifyResetCode(tRequest)).called(1);
    });

    test('should return ErrorBaseResponse when code is invalid/expired', () async {
      when(mockApiClient.verifyResetCode(any)).thenThrow(Exception("Invalid Code"));

      final result = await dataSource.verifyResetCode(tRequest);

      expect(result, isA<ErrorBaseResponse<VerifyResetCodeDTO>>());
      verify(mockApiClient.verifyResetCode(tRequest)).called(1);
    });
  });

  group('resetPassword', () {
    final tRequest = ResetPasswordRequest(email: "test@example.com", newPassword: "password123");
    final tResponseDTO = ResetPasswordDTO(token: "new_token_example", message: '');

    test('should return SuccessBaseResponse when password is reset successfully', () async {
      when(mockApiClient.resetPassword(any)).thenAnswer((_) async => tResponseDTO);

      final result = await dataSource.resetPassword(tRequest);

      expect(result, isA<SuccessBaseResponse<ResetPasswordDTO>>());
      expect((result as SuccessBaseResponse).data, tResponseDTO);
      verify(mockApiClient.resetPassword(tRequest)).called(1);
    });

    test('should return ErrorBaseResponse when reset password fails', () async {
      when(mockApiClient.resetPassword(any)).thenThrow(Exception("Server Failure"));

      final result = await dataSource.resetPassword(tRequest);

      expect(result, isA<ErrorBaseResponse<ResetPasswordDTO>>());
      verify(mockApiClient.resetPassword(tRequest)).called(1);
    });
  });
}