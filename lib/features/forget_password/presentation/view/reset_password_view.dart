import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/utilities/app_validators.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/features/forget_password/data/models/requests/reset_password_request.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';
import 'package:flower_app/features/forget_password/presentation/view_model/intent/forget_password_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(AppStrings.resetPassword, style: theme.textTheme.titleMedium),
            SizedBox(height: 10),
            Text(
              AppStrings.resetPasswordHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: 32),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppStrings.newPassword,
                hintText: AppStrings.enterPassword,
              ),
              obscureText: true,
              validator: AppValidators.validatePassword,
              controller: passwordController,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppStrings.confirmPassword,
                hintText: AppStrings.confirmPassword,
              ),
              obscureText: true,
              validator: (value) =>
                  AppValidators.confirmPassword(passwordController.text, value),
              controller: confirmPasswordController,
            ),
            SizedBox(height: 48),
            BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state.resetPasswordState.errorMessage != null &&
                    state.resetPasswordState.isLoading == false) {
                  AppLoading.toggle(context: context, isLoading: false);
                  AppMessages.showError(
                    context,
                    message: state.resetPasswordState.errorMessage!,
                  );
                }
                if (state.resetPasswordState.data != null&&
                    state.resetPasswordState.isLoading == false) {
                  AppMessages.showSuccess(
                    context,
                    message: state.resetPasswordState.data!.message,
                  );
                  // GoRouter.of(context).go(AppRouterPaths.kLoginView);
                }
                if (state.resetPasswordState.isLoading ) {
                  AppLoading.toggle(
                    context: context,
                    isLoading: state.resetPasswordState.isLoading,
                  );
                }
              },
              builder: (context, state) => ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final request = ResetPasswordRequest(
                      email: state.email!,
                      newPassword: passwordController.text,
                    );
                    context.read<ForgetPasswordCubit>().doIntent(
                      ResetPasswordIntent(request),
                    );
                  }
                },
                child: Text(AppStrings.confirm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
