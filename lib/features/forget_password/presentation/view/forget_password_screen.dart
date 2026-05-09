import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/forget_password/presentation/view/email_verification_view.dart';
import 'package:flower_app/features/forget_password/presentation/view/forget_password_email_view.dart';
import 'package:flower_app/features/forget_password/presentation/view/reset_password_view.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.password),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ForgetPasswordEmailView(controller: pageController),
            EmailVerificationView(controller: pageController),
            ResetPasswordView(),
          ],
        ),
      ),
    );
  }
}
