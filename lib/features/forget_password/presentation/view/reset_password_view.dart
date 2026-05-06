import 'package:flower_app/core/utilities/app_validators.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Form(
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
          ElevatedButton(onPressed: () {}, child: Text(AppStrings.confirm)),
        ],
      ),
    );
  }
}
