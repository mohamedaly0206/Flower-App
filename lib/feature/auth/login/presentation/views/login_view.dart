import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/utilities/app_validators.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/feature/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/feature/auth/login/presentation/view_model/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginCubit _loginCubit;

  @override
  void initState() {
    super.initState();
    _loginCubit = getIt<LoginCubit>();
  }

  @override
  void dispose() {
    AppLoading.toggle(context: context, isLoading: false);
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginCubit,
      child: BlocConsumer<LoginCubit, BaseState<LoginResponse>>(
        listener: _loginListener,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: CustomAppBar(title: AppStrings.login),
            body: SingleChildScrollView(
              child: Form(
                key: _loginCubit.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _loginCubit.emailController,
                        validator: AppValidators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: AppStrings.email,
                          labelText: AppStrings.email,
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _loginCubit.passwordController,
                        validator: AppValidators.validatePassword,
                        obscureText: _loginCubit.obscurePassword,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submitLogin(context),
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _loginCubit.toggleObscurePassword();
                              });
                            },
                            icon: Icon(
                              _loginCubit.obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                                checkColor: AppColors.placeHolderColor,
                              ),
                              Text(
                                AppStrings.rememberMe,
                                style: AppTextStyles.textStyleRegular13,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              AppStrings.forgetPassword,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: ElevatedButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () => _submitLogin(context),
                                child: Text(
                                  AppStrings.login,
                                  style: AppTextStyles.textStyleMedium16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            AppStrings.doNotHaveAnAccount,
                            style: AppTextStyles.textStyleRegular16,
                          ),
                          InkWell(
                            onTap: () {},
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
            ),
          );
        },
      ),
    );
  }

  void _loginListener(BuildContext context, BaseState<LoginResponse> state) {
    AppLoading.toggle(context: context, isLoading: state.isLoading);

    final errorMessage = state.errorMessage;
    if (errorMessage != null) {
      AppMessages.showError(context, message: errorMessage);
    }

    final loginResponse = state.data;
    if (loginResponse != null) {
      AppMessages.showSuccess(
        context,
        message: loginResponse.message ?? AppStrings.loginSuccessfully,
      );
      context.go(AppRouterPaths.kAppSections);
    }
  }

  void _submitLogin(BuildContext context) {
    if (_loginCubit.formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        email: _loginCubit.emailController.text.trim(),
        password: _loginCubit.passwordController.text,
      );
    }
  }
}
