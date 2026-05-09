
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/signup/presentation/view_model/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/model/register_params.dart';
import '../../domain/use_cases/register_use_case.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(const RegisterState());


  Future<void> register(RegisterParams params) async {
    emit(state.copyWith(status: RegisterStatus.loading, errorMessage: null));

    final result = await registerUseCase(params);

    switch (result) {
      case SuccessBaseResponse():
        emit(state.copyWith(status: RegisterStatus.success, result: result.data));
      case ErrorBaseResponse():
        emit(state.copyWith(
          status: RegisterStatus.error,
          errorMessage: result.errorMessage,
        ));
    }
  }
}