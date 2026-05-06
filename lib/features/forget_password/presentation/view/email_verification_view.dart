import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/forget_password/presentation/widgets/custom_otp_text_field.dart';
import 'package:flutter/material.dart';

class EmailVerificationView extends StatelessWidget {
  const EmailVerificationView({super.key});

  TextEditingController? get emailController => null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(AppStrings.emailVerification, style: theme.textTheme.titleMedium),
        SizedBox(height: 10),
        Text(
          AppStrings.enterCode,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 32),
        CustomOTPTextField(onSubmit: (value) {}),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.didNotReceiveCode,
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(width: 4),
            TextButton(onPressed: () {}, child: Text(AppStrings.resend)),
          ],
        ),
      ],
    );
  }
}
