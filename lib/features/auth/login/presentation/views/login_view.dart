import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/utilities/app_validators.dart';

import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/intent/login_intent.dart';
import 'package:flower_app/features/auth/login/presentation/view_model/state/login_states.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  void initState() {
    super.initState();
    context.read<LoginCubit>().doIntent(LoadRememberMeIntent());
  }

  @override
  void dispose() {
    AppLoading.toggle(context: context, isLoading: false);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: _loginListener,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.login,
          hasBackButton: false,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (value) =>
                        AppValidators.validateEmail(context, value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.email,
                      labelText: AppLocalizations.of(context)!.email,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _PasswordField(
                    controller: _passwordController,
                    onSubmitted: () => _submitLogin(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) =>
                                previous.rememberMe != current.rememberMe ||
                                (previous is LoginLoading) !=
                                    (current is LoginLoading),
                            builder: (context, state) {
                              return Checkbox(
                                value: state.rememberMe,
                                onChanged: state is LoginLoading
                                    ? null
                                    : (value) =>
                                          context.read<LoginCubit>().doIntent(
                                            ToggleRememberMeIntent(value),
                                          ),
                                checkColor: AppColors.placeHolderColor,
                                side: const BorderSide(
                                  color: AppColors.placeHolderColor,
                                  width: 2.0,
                                ),
                              );
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!.rememberMe,
                            style: AppTextStyles.textStyleRegular13,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          AppLocalizations.of(context)!.forgetPassword,
                          style: AppTextStyles.textStyleRegular12.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 42),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state is LoginLoading
                                    ? null
                                    : () => _submitLogin(context),
                                child: Text(
                                  AppLocalizations.of(context)!.login,
                                  style: AppTextStyles.textStyleMedium16,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: AppColors.greyColor,
                                    width: 1,
                                  ),
                                  backgroundColor: AppColors.whiteColor,
                                ),
                                onPressed: () {
                                  context.read<LoginCubit>().doIntent(
                                    ContinueAsGuestIntent(),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.continueasguest,
                                  style: AppTextStyles.textStyleMedium16
                                      .copyWith(color: AppColors.greyColor),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.doNotHaveAnAccount,
                        style: AppTextStyles.textStyleRegular16,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(AppRouterPaths.kSignUpView);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
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
        ),
      ),
    );
  }

  void _loginListener(BuildContext context, LoginState state) {
    AppLoading.toggle(context: context, isLoading: state is LoginLoading);

    switch (state) {
      case LoginFailure():
        AppMessages.showError(context, message: state.errorMessage);
      case LoginSuccess():
        AppMessages.showSuccess(
          context,
          message:
              state.response.message ??
              AppLocalizations.of(context)!.loginSuccessfully,
        );
        context.go(AppRouterPaths.kAppSections);
      case LoginInitial():
      case LoginLoading():
        break;
      case LoginGuestSuccess():
        context.go(AppRouterPaths.kAppSections);
    }
  }

  void _submitLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().doIntent(
        SubmitLoginIntent(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmitted;

  const _PasswordField({required this.controller, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          validator: (value) => AppValidators.validatePassword(context, value),
          obscureText: state.obscurePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => onSubmitted(),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.password,
            labelText: AppLocalizations.of(context)!.password,
            suffixIcon: IconButton(
              onPressed: () {
                context.read<LoginCubit>().doIntent(
                  TogglePasswordVisibilityIntent(),
                );
              },
              icon: Icon(
                state.obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
            ),
          ),
        );
      },
    );
  }
}
