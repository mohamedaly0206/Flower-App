import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditProfileAvatarWidget extends StatelessWidget {
  final String? photoUrl;
  final File? localPhotoFile;
  final bool isLoading;

  const EditProfileAvatarWidget({
    super.key,
    this.photoUrl,
    this.localPhotoFile,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 81,
      height: 81,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondaryColor,
      ),
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (localPhotoFile != null)
              Image.file(localPhotoFile!, fit: BoxFit.cover)
            else if (photoUrl != null && photoUrl!.isNotEmpty)
              CachedNetworkImage(
                key: ValueKey(photoUrl),
                imageUrl: photoUrl!,
                fit: BoxFit.cover,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
                errorWidget: (_, __, ___) => const Icon(
                  Icons.person_rounded,
                  size: 48,
                  color: AppColors.primaryColor,
                ),
              )
            else
              const Icon(
                Icons.person_rounded,
                size: 48,
                color: AppColors.primaryColor,
              ),
            if (isLoading)
              Container(
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
