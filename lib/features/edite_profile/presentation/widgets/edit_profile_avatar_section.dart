import 'dart:io';

import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/edite_profile/presentation/widgets/edit_profile_avatar_widget.dart';
import 'package:flutter/material.dart';

class EditProfileAvatarSection extends StatelessWidget {
  final String? photoUrl;
  final File? localPhotoFile;
  final bool isImageUploading;
  final VoidCallback? onPickImage;

  const EditProfileAvatarSection({
    super.key,
    this.photoUrl,
    this.localPhotoFile,
    required this.isImageUploading,
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          EditProfileAvatarWidget(
            photoUrl: photoUrl,
            localPhotoFile: localPhotoFile,
            isLoading: isImageUploading,
          ),
          GestureDetector(
            onTap: isImageUploading ? null : onPickImage,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.greyColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
