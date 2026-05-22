import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditProfileUpdateButton extends StatelessWidget {
  final bool isLoading;
  final bool isEnabled;
  final VoidCallback? onPressed;

  const EditProfileUpdateButton({
    super.key,
    required this.isLoading,
    required this.isEnabled,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        key: const Key('edit_profile_update_button'),
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          disabledBackgroundColor: AppColors.primaryColor.withOpacity(0.6),
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Text(
                'Update',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
