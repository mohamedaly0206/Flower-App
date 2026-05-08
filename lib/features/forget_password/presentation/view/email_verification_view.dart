import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/features/forget_password/data/models/requests/enter_reset_email_request.dart';
import 'package:flower_app/features/forget_password/data/models/requests/verify_reset_code_request.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/intent/forget_password_intent.dart';
import 'package:flower_app/features/forget_password/presentation/widgets/custom_otp_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.verifyResetCodeState.errorMessage != null &&
            state.verifyResetCodeState.isLoading == false) {
          AppLoading.toggle(context: context, isLoading: false);
          AppMessages.showError(
            context,
            message: state.verifyResetCodeState.errorMessage!,
          );
        }
        if (state.verifyResetCodeState.isLoading) {
          AppLoading.toggle(
            context: context,
            isLoading: state.verifyResetCodeState.isLoading,
          );
        }
        if (state.verifyResetCodeState.data != null &&
            state.verifyResetCodeState.isLoading == false) {
                        AppLoading.toggle(context: context, isLoading: false);

          controller.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.emailVerification,
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 10),
              Text(
                AppStrings.enterCode,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 32),

              CustomOTPTextField(
                state: state,
                onSubmit: (otp) {
                  final request = VerifyResetCodeRequest(code: otp);
                  context.read<ForgetPasswordCubit>().doIntent(
                    VerifyResetCodeIntent(request),
                  );
                },
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.didNotReceiveCode,
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      final request = EnterResetEmailRequest(
                        email: state.email,
                      );
                      context.read<ForgetPasswordCubit>().doIntent(
                        EnterResetEmailIntent(request),
                      );
                    },
                    child: Text(AppStrings.resend),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
