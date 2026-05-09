import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/forget_password/api/api_client/forget_password_api_client.dart';
import 'package:flower_app/features/forget_password/api/data_sources/forget_password_remote_data_source_impl.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/data/models/responses/enter_reset_email_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/reset_password_dto.dart';
import 'package:flower_app/features/forget_password/data/models/responses/verify_reset_code_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ForgetPasswordApiClient])
void main() {
  late ForgetPasswordRemoteDataSourceImpl dataSource;
  late MockForgetPasswordApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockForgetPasswordApiClient();
    dataSource = ForgetPasswordRemoteDataSourceImpl(
      forgetPasswordApiClient: mockApiClient,
    );
  });

  group('enterResetEmail', () {
    final tRequest = EnterResetEmailRequest(email: "test@example.com");
    final tResponseDTO = EnterResetEmailDTO(message: "Success", info: '');

    test(
      'should return SuccessBaseResponse when API call is successful',
      () async {
        when(
          mockApiClient.enterResetEmail(any),
        ).thenAnswer((_) async => tResponseDTO);

        final result = await dataSource.enterResetEmail(tRequest);

        expect(result, isA<SuccessBaseResponse<EnterResetEmailDTO>>());
        expect((result as SuccessBaseResponse).data, tResponseDTO);
        verify(mockApiClient.enterResetEmail(tRequest)).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse with mapped ServerFailure message on DioException',
      () async {
        // Arrange: Simulate a 404 error via Dio
        final tDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 404,
          ),
        );

        when(mockApiClient.enterResetEmail(any)).thenThrow(tDioException);

        // Act
        final result = await dataSource.enterResetEmail(tRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<EnterResetEmailDTO>>());
        final errorResult = result as ErrorBaseResponse;

        // PR FIX: Check if the message matches the Failure handler's output
        final expectedMessage = ServerFailure.failureHandler(
          tDioException,
        ).errorMessage;
        expect(errorResult.errorMessage, expectedMessage);
      },
    );
  });

  group('verifyResetCode', () {
    final tRequest = VerifyResetCodeRequest(code: '123456');
    final tResponseDTO = VerifyResetCodeDTO(status: "Verified");

    test('should return SuccessBaseResponse when code is valid', () async {
      when(
        mockApiClient.verifyResetCode(any),
      ).thenAnswer((_) async => tResponseDTO);

      final result = await dataSource.verifyResetCode(tRequest);

      expect(result, isA<SuccessBaseResponse<VerifyResetCodeDTO>>());
      expect((result as SuccessBaseResponse).data, tResponseDTO);
    });

    test(
      'should return ErrorBaseResponse with default message on generic Exception',
      () async {
        // Arrange
        final tException = Exception("Unexpected Error");
        when(mockApiClient.verifyResetCode(any)).thenThrow(tException);

        // Act
        final result = await dataSource.verifyResetCode(tRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<VerifyResetCodeDTO>>());
        final errorResult = result as ErrorBaseResponse;

        final expectedMessage = ServerFailure.failureHandler(
          tException,
        ).errorMessage;
        expect(errorResult.errorMessage, expectedMessage);
      },
    );
  });

  group('resetPassword', () {
    final tRequest = ResetPasswordRequest(
      email: "test@example.com",
      newPassword: "password123",
    );
    final tResponseDTO = ResetPasswordDTO(
      token: "new_token",
      message: 'Success',
    );

    test(
      'should return SuccessBaseResponse when password is reset successfully',
      () async {
        when(
          mockApiClient.resetPassword(any),
        ).thenAnswer((_) async => tResponseDTO);

        final result = await dataSource.resetPassword(tRequest);

        expect(result, isA<SuccessBaseResponse<ResetPasswordDTO>>());
        expect((result as SuccessBaseResponse).data, tResponseDTO);
      },
    );

    test(
      'should return ErrorBaseResponse with custom message from response data (400/401/409)',
      () async {
        const customErrorMessage = "Unauthorized access";
        final tDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 401,
            data: {'message': customErrorMessage},
          ),
        );

        when(mockApiClient.resetPassword(any)).thenThrow(tDioException);

        // Act
        final result = await dataSource.resetPassword(tRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<ResetPasswordDTO>>());
        final errorResult = result as ErrorBaseResponse;
        expect(errorResult.errorMessage, customErrorMessage);
      },
    );
  });
}
