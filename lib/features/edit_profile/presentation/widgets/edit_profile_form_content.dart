import 'package:flower_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/intent/edit_profile_intent.dart';
import 'package:flower_app/features/edit_profile/presentation/view_model/state/edit_profile_state.dart';
import 'package:flower_app/features/edit_profile/presentation/widgets/edit_profile_avatar_section.dart';
import 'package:flower_app/features/edit_profile/presentation/widgets/edit_profile_gender_row.dart';
import 'package:flower_app/features/edit_profile/presentation/widgets/edit_profile_password_row.dart';
import 'package:flower_app/features/edit_profile/presentation/widgets/edit_profile_text_field.dart';
import 'package:flower_app/features/edit_profile/presentation/widgets/edit_profile_update_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileFormContent extends StatelessWidget {
  final EditProfileState state;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final VoidCallback onPickImage;

  const EditProfileFormContent({
    super.key,
    required this.state,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    final isLoading = state.status == EditProfileStatus.loading;
    final isImageUploading = state.status == EditProfileStatus.imageUploading;
    final isFormEnabled = state.user != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EditProfileAvatarSection(
            photoUrl: state.user?.photo,
            localPhotoFile: state.localPhotoFile,
            isImageUploading: isImageUploading,
            onPickImage: onPickImage,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: EditProfileTextField(
                  id: 'edit_profile_first_name',
                  label: 'First name',
                  controller: firstNameController,
                  enabled: isFormEnabled,
                  onChanged: (v) =>
                      cubit.handleIntent(UpdateFirstNameIntent(v)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: EditProfileTextField(
                  id: 'edit_profile_last_name',
                  label: 'Last name',
                  controller: lastNameController,
                  enabled: isFormEnabled,
                  onChanged: (v) => cubit.handleIntent(UpdateLastNameIntent(v)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          EditProfileTextField(
            id: 'edit_profile_email',
            label: 'Email',
            controller: emailController,
            enabled: isFormEnabled,
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) => cubit.handleIntent(UpdateEmailIntent(v)),
          ),
          const SizedBox(height: 24),
          EditProfileTextField(
            id: 'edit_profile_phone',
            label: 'Phone number',
            controller: phoneController,
            enabled: isFormEnabled,
            keyboardType: TextInputType.phone,
            onChanged: (v) => cubit.handleIntent(UpdatePhoneIntent(v)),
          ),
          const SizedBox(height: 24),
          const EditProfilePasswordRow(),
          const SizedBox(height: 24),
          EditProfileGenderRow(
            selectedGender: state.user?.gender,
            onChanged: (g) => cubit.handleIntent(UpdateGenderIntent(g)),
          ),
          const SizedBox(height: 48),
          EditProfileUpdateButton(
            isLoading: isLoading,
            isEnabled: !isLoading && !isImageUploading && isFormEnabled,
            onPressed: () =>
                cubit.handleIntent(const SubmitProfileUpdateIntent()),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
