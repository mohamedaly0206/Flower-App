import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/signup/data/data_sources/register_remote_datasource_contract.dart';
import 'package:flower_app/features/auth/signup/data/model/register_request.dart';
import 'package:flower_app/features/auth/signup/data/model/register_response.dart';
import 'package:flower_app/features/auth/signup/data/repositories/register_repo_impl.dart';
import 'package:flower_app/features/auth/signup/domain/model/register_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterRemoteDatasource extends Mock
    implements RegisterRemoteDatasourceContract {}

void main() {
  late RegisterRepoImpl repository;
  late MockRegisterRemoteDatasource mockRemoteDatasource;

  setUpAll(() {
    registerFallbackValue(RegisterRequest());
  });

  setUp(() {
    mockRemoteDatasource = MockRegisterRemoteDatasource();
    repository = RegisterRepoImpl(mockRemoteDatasource);
  });

  final tRegisterParams = RegisterParams(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    password: 'password123',
    rePassword: 'password123',
    phone: '01234567890',
    gender: 'male',
  );

  final tRegisterResponse = RegisterResponse(
    message: 'Success',
    token: 'token123',
    user: UserResponse(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phone: '01234567890',
      gender: 'male',
      role: 'user',
      isVerified: false,
      createdAt: '2023-01-01',
    ),
  );

  group('register', () {
    test(
      'should return SuccessBaseResponse when call to remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDatasource.register(any()),
        ).thenAnswer((_) async => tRegisterResponse);

        // act
        final result = await repository.register(tRegisterParams);

        // assert
        expect(result, isA<SuccessBaseResponse>());
        verify(() => mockRemoteDatasource.register(any())).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse when call to remote data source fails',
      () async {
        // arrange
        when(
          () => mockRemoteDatasource.register(any()),
        ).thenThrow(Exception('Something went wrong'));

        // act
        final result = await repository.register(tRegisterParams);

        // assert
        expect(result, isA<ErrorBaseResponse>());
        verify(() => mockRemoteDatasource.register(any())).called(1);
      },
    );
  });
}
