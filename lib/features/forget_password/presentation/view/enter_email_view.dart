import 'package:flower_app/core/utilities/app_validators.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class EnterEmailView extends StatelessWidget {
  EnterEmailView({super.key});
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(AppStrings.forgetPassword, style: theme.textTheme.titleMedium),
          SizedBox(height: 10),
          Text(
            AppStrings.enterEmail,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 32),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppStrings.email,
              hintText: AppStrings.enterEmail,
            ),
            validator: AppValidators.validateEmail,
            controller: emailController,
          ),
          SizedBox(height: 48),
          ElevatedButton(onPressed: () {}, child: Text(AppStrings.confirm)),
        ],
      ),
    );
  }
}
