import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/signup/domain/model/register_details.dart';
import 'package:flower_app/features/auth/signup/domain/model/register_params.dart';
import 'package:flower_app/features/auth/signup/domain/model/user_entity.dart';
import 'package:flower_app/features/auth/signup/domain/use_cases/register_use_case.dart';
import 'package:flower_app/features/auth/signup/presentation/view_model/register_cubit.dart';
import 'package:flower_app/features/auth/signup/presentation/view_model/register_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

void main() {
  late RegisterCubit registerCubit;
  late MockRegisterUseCase mockRegisterUseCase;

  setUpAll(() {
    registerFallbackValue(
      RegisterParams(
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        rePassword: '',
        phone: '',
        gender: '',
      ),
    );
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    registerCubit = RegisterCubit(mockRegisterUseCase);
  });

  tearDown(() {
    registerCubit.close();
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

  test('initial state should be RegisterState()', () {
    expect(registerCubit.state, const RegisterState());
  });

  group('register', () {
    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, success] when register is successful',
      build: () {
        when(
          () => mockRegisterUseCase(any()),
        ).thenAnswer((_) async => SuccessBaseResponse(data: tRegisterDetails));
        return registerCubit;
      },
      act: (cubit) => cubit.register(tRegisterParams),
      expect: () => [
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
          status: RegisterStatus.success,
          result: tRegisterDetails,
        ),
      ],
      verify: (_) {
        verify(() => mockRegisterUseCase(tRegisterParams)).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits [loading, error] when register fails',
      build: () {
        when(() => mockRegisterUseCase(any())).thenAnswer(
          (_) async => ErrorBaseResponse(errorMessage: 'Error message'),
        );
        return registerCubit;
      },
      act: (cubit) => cubit.register(tRegisterParams),
      expect: () => [
        const RegisterState(status: RegisterStatus.loading),
        const RegisterState(
          status: RegisterStatus.error,
          errorMessage: 'Error message',
        ),
      ],
      verify: (_) {
        verify(() => mockRegisterUseCase(tRegisterParams)).called(1);
      },
    );
  });
}
