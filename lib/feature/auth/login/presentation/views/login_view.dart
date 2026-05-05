import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/utilities/app_validators.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(title: AppStrings.login),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16,
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        validator: AppValidators.validateEmail,
                        decoration: const InputDecoration(
                          hintText: AppStrings.email,
                          labelText: AppStrings.email,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: AppValidators.validatePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(value: false, onChanged: (v) {}),
                            Text(
                              AppStrings.rememberMe,
                              style: AppTextStyles.textStyleRegular13,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Text(
                                AppStrings.forgetPassword,
                                style: AppTextStyles.textStyleRegular12
                                    .copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 42)),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        child: Text(
                          AppStrings.login,
                          style: AppTextStyles.textStyleMedium16,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 22)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.doNotHaveAnAccount,
                    style: AppTextStyles.textStyleRegular16,
                  ),
                  InkWell(
                    onTap: () {
                      //ToDo navigate to sign up screen
                    },
                    child: Text(
                      AppStrings.signUp,
                      style: AppTextStyles.textStyleMedium16.copyWith(
                        decoration: TextDecoration.underline,
                        color: AppColors.primaryColor,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
