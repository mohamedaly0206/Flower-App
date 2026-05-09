import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/signup/domain/model/register_details.dart';
import 'package:flower_app/features/signup/domain/model/register_params.dart';
import 'package:flower_app/features/signup/domain/model/user_entity.dart';
import 'package:flower_app/features/signup/domain/repositories/register_repo_contract.dart';
import 'package:flower_app/features/signup/domain/use_cases/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterRepo extends Mock implements RegisterRepoContract {}

void main() {
  late RegisterUseCase useCase;
  late MockRegisterRepo mockRegisterRepo;

  setUpAll(() {
    registerFallbackValue(RegisterParams(
      firstName: '',
      lastName: '',
      email: '',
      password: '',
      rePassword: '',
      phone: '',
      gender: '',
    ));
  });

  setUp(() {
    mockRegisterRepo = MockRegisterRepo();
    useCase = RegisterUseCase(mockRegisterRepo);
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

  const tUserEntity = UserEntity(
    id: '1',
    firstName: 'John',
    lastName: 'Doe',
    email: 'john.doe@example.com',
    phone: '01234567890',
    gender: 'male',
    role: 'user',
    isVerified: false,
    createdAt: '2023-01-01',
  );

  const tRegisterDetails = RegisterDetails(
    message: 'Success',
    token: 'token123',
    user: tUserEntity,
  );

  test('should call register on the repository', () async {
    // arrange
    when(() => mockRegisterRepo.register(any()))
        .thenAnswer((_) async => SuccessBaseResponse(data: tRegisterDetails));

    // act
    final result = await useCase(tRegisterParams);

    // assert
    expect(result, isA<SuccessBaseResponse<RegisterDetails>>());
    expect((result as SuccessBaseResponse).data, tRegisterDetails);
    verify(() => mockRegisterRepo.register(tRegisterParams)).called(1);
    verifyNoMoreInteractions(mockRegisterRepo);
  });
}
