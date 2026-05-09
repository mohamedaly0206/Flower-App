import 'package:flower_app/features/signup/api/api_services/api_services.dart';
import 'package:flower_app/features/signup/api/data_sources/register_remote_datasource_impl.dart';
import 'package:flower_app/features/signup/data/model/register_request.dart';
import 'package:flower_app/features/signup/data/model/register_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterApiService extends Mock implements RegisterApiService {}

void main() {
  late RegisterRemoteDatasourceImpl dataSource;
  late MockRegisterApiService mockApiService;

  setUpAll(() {
    registerFallbackValue(RegisterRequest());
  });

  setUp(() {
    mockApiService = MockRegisterApiService();
    dataSource = RegisterRemoteDatasourceImpl(mockApiService);
  });

  final tRegisterRequest = RegisterRequest(
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
  );

  test('should call register on the API service', () async {
    // arrange
    when(() => mockApiService.register(any()))
        .thenAnswer((_) async => tRegisterResponse);

    // act
    final result = await dataSource.register(tRegisterRequest);

    // assert
    expect(result, tRegisterResponse);
    verify(() => mockApiService.register(tRegisterRequest)).called(1);
  });
}
