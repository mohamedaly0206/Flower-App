import 'dart:io';

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/intent/edit_profile_intent.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/state/edit_profile_state.dart';
import 'package:flower_app/features/edit_profile/presentation/widgets/edit_profile_form_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _firstNameCtrl;
  late TextEditingController _lastNameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;

  bool _controllersInitialized = false;

  @override
  void initState() {
    super.initState();
    _firstNameCtrl = TextEditingController();
    _lastNameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditProfileCubit>().handleIntent(const FetchProfileIntent());
    });
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _syncControllers(EditProfileState state) {
    if (!_controllersInitialized && state.user != null) {
      _controllersInitialized = true;
      _firstNameCtrl.text = state.user!.firstName ?? '';
      _lastNameCtrl.text = state.user!.lastName ?? '';
      _emailCtrl.text = state.user!.email ?? '';
      _phoneCtrl.text = state.user!.phone ?? '';
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null && mounted) {
      context.read<EditProfileCubit>().handleIntent(
        UploadPhotoIntent(File(picked.path)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        _syncControllers(state);
        if (state.status == EditProfileStatus.error &&
            state.errorMessage != null) {
        AppMessages.showError(context, message: state.errorMessage!);
        }
        if (state.status == EditProfileStatus.success &&
            state.successMessage != null) {
          if (state.user != null) {
            _firstNameCtrl.text = state.user!.firstName ?? '';
            _lastNameCtrl.text = state.user!.lastName ?? '';
            _emailCtrl.text = state.user!.email ?? '';
            _phoneCtrl.text = state.user!.phone ?? '';
          }
          AppMessages.showSuccess(
            context,
            message: state.successMessage!,
          );
        }
      },
      builder: (context, state) {
        final isInitialLoading =
            state.status == EditProfileStatus.loading && state.user == null;

        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CustomAppBar(
            title: AppStrings.editProfile,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.notifications_none_outlined,
                      size: 28,
                      color: AppColors.blackColor,
                    ),
                    Positioned(
                      right: -2,
                      top: -6,
                      child: Container(
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColors.errorColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '0',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: isInitialLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : EditProfileFormContent(
                  state: state,
                  firstNameController: _firstNameCtrl,
                  lastNameController: _lastNameCtrl,
                  emailController: _emailCtrl,
                  phoneController: _phoneCtrl,
                  onPickImage: _pickImage,
                ),
        );
      },
    );
  }
}
