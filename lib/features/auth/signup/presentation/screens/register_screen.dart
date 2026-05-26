import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/features/auth/signup/presentation/view_model/register_cubit.dart';
import 'package:flower_app/features/auth/signup/presentation/view_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/utilities/app_validators.dart';

import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../domain/model/register_params.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedGender = "female";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          AppLoading.toggle(
            context: context,
            isLoading: state.status == RegisterStatus.loading,
          );
          if (state.status == RegisterStatus.error) {
            AppMessages.showError(context, message: state.errorMessage!);
          }
          if (state.status == RegisterStatus.success) {
            AppMessages.showSuccess(
              context,
              message: AppLocalizations.of(context)!.signUpSuccessMessage,
            );
            GoRouter.of(context).go(AppRouterPaths.kLoginView);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(title: AppLocalizations.of(context)!.signUp),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                )!.firstName,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.hintFirstNameText,
                              ),
                              validator: (value) => AppValidators.validateName(
                                context,
                                value,
                                AppLocalizations.of(context)!.firstName,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                )!.lastName,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.enterYourLastName,
                              ),
                              validator: (value) => AppValidators.validateName(
                                context,
                                value,
                                AppLocalizations.of(context)!.lastName,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.email,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enterYourEmail,
                        ),
                        validator: (value) => AppValidators.validateEmail(
                          context,
                          value,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                )!.password,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.enterPassword,
                              ),
                              validator: (value) =>
                                  AppValidators.validatePassword(
                                context,
                                value,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(
                                  context,
                                )!.confirmPassword,
                                hintText: AppLocalizations.of(
                                  context,
                                )!.confirmPassword,
                              ),
                              validator: (value) =>
                                  AppValidators.confirmPassword(
                                    context,
                                    _passwordController.text,
                                    value,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.phone,
                          hintText: AppLocalizations.of(
                            context,
                          )!.enterPhoneNumber,
                        ),
                        validator: (value) => AppValidators.validatePhoneNumber(
                          context,
                          value,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.gender,
                            style: AppTextStyles.textStyleMedium18.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Radio<String>(
                            value: "female",
                            groupValue: _selectedGender,
                            activeColor: AppColors.primaryColor,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!.female,
                            style: AppTextStyles.textStyleRegular16.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Radio<String>(
                            value: "male",
                            groupValue: _selectedGender,
                            activeColor: AppColors.primaryColor,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!.male,
                            style: AppTextStyles.textStyleRegular16.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.textStyleRegular14.copyWith(
                            color: AppColors.blackColor,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  '${AppLocalizations.of(context)!.creatingAnAccountYouAgreeToOur} ',
                            ),
                            TextSpan(
                              text: AppLocalizations.of(
                                context,
                              )!.termsAndConditions,
                              style: AppTextStyles.textStyleMedium14.copyWith(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                              RegisterParams(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                gender:
                                    _selectedGender?.toLowerCase() ?? 'male',
                                password: _passwordController.text,
                                rePassword: _confirmPasswordController.text,
                              ),
                            );
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.signUp),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.alreadyHaveAnAccount} ',
                            style: AppTextStyles.textStyleRegular16.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              GoRouter.of(
                                context,
                              ).go(AppRouterPaths.kLoginView);
                            },
                            child: Text(AppLocalizations.of(context)!.login),
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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
