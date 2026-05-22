import 'package:flower_app/core/widgets/app_loading.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/router_paths.dart';
import '../../../../core/utilities/app_validators.dart';
import '../../../../core/values/app_strings.dart';
import '../view_model/cubit/change_password_cubit.dart';
import '../view_model/intent/change_password_intent.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    AppLoading.toggle(context: context, isLoading: false);
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.resetPassword),
          centerTitle: true,
        ),
        body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
          listenWhen: (previous, current) =>
              previous.changePasswordState != current.changePasswordState,
          listener: (context, state) {
            AppLoading.toggle(
              context: context,
              isLoading: state.changePasswordState.isLoading,
            );

            if (!state.changePasswordState.isLoading &&
                state.changePasswordState.data != null) {
              AppMessages.showSuccess(
                context,
                message: AppStrings.changePasswordSuccess,
              );
              GoRouter.of(context).go(AppRouterPaths.kLoginView);
            } else if (state.changePasswordState.errorMessage != null &&
                !state.changePasswordState.isLoading) {
              AppMessages.showError(
                context,
                message: state.changePasswordState.errorMessage!,
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: currentPasswordController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.currentPassword,
                        hintText: AppStrings.currentPassword,
                      ),
                      validator: (value) =>
                          AppValidators.validateEmptyTextFormField(value),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: newPasswordController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.newPassword,
                        hintText: AppStrings.newPassword,
                      ),
                      validator: (value) =>
                          AppValidators.validatePassword(value),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: AppStrings.confirmPassword,
                        hintText: AppStrings.confirmPassword,
                      ),
                      validator: (value) => AppValidators.confirmPassword(
                        newPasswordController.text,
                        value,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.changePasswordState.isLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    if (newPasswordController.text !=
                                        confirmPasswordController.text) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            AppStrings.passwordNotMatched,
                                          ),
                                          backgroundColor: Theme.of(
                                            context,
                                          ).colorScheme.error,
                                        ),
                                      );
                                      return;
                                    }

                                    context
                                        .read<ChangePasswordCubit>()
                                        .handleIntent(
                                          ExecuteChangePasswordIntent(
                                            oldPassword:
                                                currentPasswordController.text,
                                            newPassword:
                                                newPasswordController.text,
                                          ),
                                        );
                                  }
                                },
                          child: const Text(AppStrings.update),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
