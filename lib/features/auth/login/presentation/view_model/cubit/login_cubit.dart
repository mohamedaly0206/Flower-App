import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/features/auth/login/domain/use_case/login_use_case.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/intent/login_intent.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/state/login_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginInitial());

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case TogglePasswordVisibilityIntent():
        togglePasswordVisibility();
      case LoadRememberMeIntent():
        loadRememberMe();
      case ToggleRememberMeIntent():
        toggleRememberMe(intent.value);
      case SubmitLoginIntent():
        login(email: intent.email, password: intent.password);
    }
  }

  void togglePasswordVisibility() {
    if (state is LoginLoading) return;

    emit(
      LoginInitial(
        obscurePassword: !state.obscurePassword,
        rememberMe: state.rememberMe,
      ),
    );
  }

  Future<void> loadRememberMe() async {
    final rememberMe = await _loginUseCase.getRememberMe();

    emit(
      LoginInitial(
        obscurePassword: state.obscurePassword,
        rememberMe: rememberMe,
      ),
    );
  }

  void toggleRememberMe(bool? value) {
    if (state is LoginLoading) return;

    emit(
      LoginInitial(
        obscurePassword: state.obscurePassword,
        rememberMe: value ?? false,
      ),
    );
  }

  Future<void> login({required String email, required String password}) async {
    if (state is LoginLoading) return;

    final obscurePassword = state.obscurePassword;
    final rememberMe = state.rememberMe;

    emit(
      LoginLoading(obscurePassword: obscurePassword, rememberMe: rememberMe),
    );

    final result = await _loginUseCase(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    switch (result) {
      case SuccessBaseResponse<LoginResponse>():
        emit(
          LoginSuccess(
            result.data,
            obscurePassword: obscurePassword,
            rememberMe: rememberMe,
          ),
        );
      case ErrorBaseResponse<LoginResponse>():
        emit(
          LoginFailure(
            result.errorMessage,
            obscurePassword: obscurePassword,
            rememberMe: rememberMe,
          ),
        );
    }
  }
}
