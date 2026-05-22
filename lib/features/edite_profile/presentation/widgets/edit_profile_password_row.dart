import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditProfilePasswordRow extends StatelessWidget {
  const EditProfilePasswordRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: '••••••••',
              enabled: false,
              obscureText: true,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 3,
                color: AppColors.blackColor,
              ),
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  fontSize: 13,
                  color: AppColors.placeHolderColor,
                ),
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          TextButton(
            key: const Key('edit_profile_change_password'),
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Change',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
