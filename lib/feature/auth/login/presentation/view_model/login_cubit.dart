import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/feature/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/feature/auth/login/domain/use_case/login_use_case.dart';
import 'package:flower_app/feature/auth/login/presentation/view_model/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitial());

  void togglePasswordVisibility() {
    if (state is LoginLoading) return;

    emit(LoginInitial(obscurePassword: !state.obscurePassword));
  }

  Future<void> login({required String email, required String password}) async {
    if (state is LoginLoading) return;

    final obscurePassword = state.obscurePassword;

    emit(LoginLoading(obscurePassword: obscurePassword));

    final result = await _loginUseCase(email: email, password: password);

    switch (result) {
      case SuccessBaseResponse<LoginResponse>():
        emit(LoginSuccess(result.data, obscurePassword: obscurePassword));
      case ErrorBaseResponse<LoginResponse>():
        emit(
          LoginFailure(result.errorMessage, obscurePassword: obscurePassword),
        );
    }
  }
}
