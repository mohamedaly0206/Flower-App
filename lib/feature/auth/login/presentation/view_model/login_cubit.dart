import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/feature/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/feature/auth/login/domain/use_case/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<BaseState<LoginResponse>> {
  final LoginUseCase _loginUseCase;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  LoginCubit(this._loginUseCase) : super(const BaseState<LoginResponse>());

  void toggleObscurePassword() {
    obscurePassword = !obscurePassword;
  }

  Future<void> login({required String email, required String password}) async {
    if (state.isLoading) return;

    emit(const BaseState<LoginResponse>(isLoading: true));

    final result = await _loginUseCase(email: email, password: password);

    switch (result) {
      case SuccessBaseResponse<LoginResponse>():
        emit(BaseState<LoginResponse>(data: result.data));
      case ErrorBaseResponse<LoginResponse>():
        emit(BaseState<LoginResponse>(errorMessage: result.errorMessage));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
