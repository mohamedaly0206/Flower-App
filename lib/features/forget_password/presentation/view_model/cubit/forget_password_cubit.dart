import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/domain/entities/enter_reset_email_entity.dart';
import 'package:flower_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:flower_app/features/forget_password/domain/entities/verify_reset_code_entity.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/enter_reset_email_use_case.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flower_app/features/forget_password/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/intent/forget_password_intent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part '../state/forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(
    this._enterResetEmailUseCase,
    this._resetPasswordUseCase,
    this._verifyResetCodeUseCase,
  ) : super(ForgetPasswordState());
  final EnterResetEmailUseCase _enterResetEmailUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;

  void doIntent(ForgetPasswordIntent intent) {
    switch (intent) {
      case EnterResetEmailIntent():
        _enterEmail(intent.request);
        break;
      case VerifyResetCodeIntent():
        _verifyResetCode(intent.request);
        break;
      case ResetPasswordIntent():
        _resetPassword(intent.request);
        break;
    }
  }

  Future<void> _enterEmail(EnterResetEmailRequest request) async {
    emit(
      state.copyWith(
        enterEmailState: state.enterEmailState.copyWith(
          isLoadingParam: true,
          dataParam: null,
          errorMessageParam: null,
        ),
      ),
    );
    final response = await _enterResetEmailUseCase.call(request);
    if (response is SuccessBaseResponse<EnterResetEmailEntity>) {
      emit(
        state.copyWith(
          enterEmailState: state.enterEmailState.copyWith(
            dataParam: response.data,
            isLoadingParam: false,
            errorMessageParam: null,
          ),
        ),
      );
      emit(state.copyWith(email: request.email));
    } else if (response is ErrorBaseResponse<EnterResetEmailEntity>) {
      emit(
        state.copyWith(
          enterEmailState: state.enterEmailState.copyWith(
            errorMessageParam: response.errorMessage,
            isLoadingParam: false,
            dataParam: null,
          ),
        ),
      );
    }
  }

  Future<void> _verifyResetCode(VerifyResetCodeRequest request) async {
    emit(
      state.copyWith(
        verifyResetCodeState: state.verifyResetCodeState.copyWith(
          isLoadingParam: true,
          dataParam: null,
          errorMessageParam: null,
        ),
      ),
    );
    final response = await _verifyResetCodeUseCase.call(request);
    if (response is SuccessBaseResponse<VerifyResetCodeEntity>) {
      emit(
        state.copyWith(
          verifyResetCodeState: state.verifyResetCodeState.copyWith(
            dataParam: response.data,
            isLoadingParam: false,
            errorMessageParam: null,
          ),
        ),
      );
    } else if (response is ErrorBaseResponse<VerifyResetCodeEntity>) {
      emit(
        state.copyWith(
          verifyResetCodeState: state.verifyResetCodeState.copyWith(
            errorMessageParam: response.errorMessage,
            isLoadingParam: false,
            dataParam: null,
          ),
        ),
      );
    }
  }

  Future<void> _resetPassword(ResetPasswordRequest request) async {
    emit(
      state.copyWith(
        resetPasswordState: state.resetPasswordState.copyWith(
          isLoadingParam: true,
          dataParam: null,
          errorMessageParam: null,
        ),
      ),
    );
    final response = await _resetPasswordUseCase.call(request);
    if (response is SuccessBaseResponse<ResetPasswordEntity>) {
      emit(
        state.copyWith(
          resetPasswordState: state.resetPasswordState.copyWith(
            dataParam: response.data,
            isLoadingParam: false,
            errorMessageParam: null,
          ),
        ),
      );
    } else if (response is ErrorBaseResponse<ResetPasswordEntity>) {
      emit(
        state.copyWith(
          resetPasswordState: state.resetPasswordState.copyWith(
            errorMessageParam: response.errorMessage,
            isLoadingParam: false,
            dataParam: null,
          ),
        ),
      );
    }
  }
}
