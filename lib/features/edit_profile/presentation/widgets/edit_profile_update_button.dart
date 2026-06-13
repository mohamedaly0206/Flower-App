import 'package:flower_app/core/values/app_strings.dart';
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
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : const Text(AppStrings.updateProfile),
      ),
    );
  }
}
