import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/base_state/base_state.dart';
import '../../../data/models/change_password_request.dart';
import '../../../domain/entities/change_password_response_entity.dart';
import '../../../domain/use_cases/change_password_use_case.dart';
import '../intent/change_password_intent.dart';
part '../state/change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit(this.changePasswordUseCase)
    : super(const ChangePasswordState());

  void handleIntent(ChangePasswordIntent intent) async {
    switch (intent) {
      case ExecuteChangePasswordIntent():
        await _changePassword(
          oldPassword: intent.oldPassword,
          newPassword: intent.newPassword,
        );
        break;
    }
  }

  Future<void> _changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    log('changePassword loading...');
    emit(
      state.copyWith(
        changePasswordState: state.changePasswordState.copyWith(
          isLoadingParam: true,
          errorMessageParam: null,
          dataParam: null,
        ),
      ),
    );

    final response = await changePasswordUseCase.call(
      ChangePasswordRequest(password: oldPassword, newPassword: newPassword),
    );

    if (response is SuccessBaseResponse<ChangePasswordResponseEntity>) {
      emit(
        state.copyWith(
          changePasswordState: state.changePasswordState.copyWith(
            isLoadingParam: false,
            dataParam: response.data,
            errorMessageParam: null,
          ),
        ),
      );
      log('changePassword success...');
    } else {
      final error = response as ErrorBaseResponse<ChangePasswordResponseEntity>;
      log('ChangePassword Error: ${error.errorMessage}');
      emit(
        state.copyWith(
          changePasswordState: state.changePasswordState.copyWith(
            isLoadingParam: false,
            errorMessageParam: error.errorMessage,
            dataParam: null,
          ),
        ),
      );
    }
  }
}
