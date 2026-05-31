import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/features/edite_profile/domain/entities/edit_profile_body.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EditProfileGenderRow extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String> onChanged;

  const EditProfileGenderRow({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final groupValue = normalizeProfileGender(selectedGender);

    return Row(
      children: [
        Text(
          l10n.gender,
          style: AppTextStyles.textStyleMedium18.copyWith(
            color: AppColors.greyColor,
          ),
        ),
        const SizedBox(width: 16),
        Radio<String>(
          key: const Key('edit_profile_gender_female'),
          value: 'female',
          groupValue: groupValue,
          activeColor: AppColors.primaryColor,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
        Text(
          l10n.female,
          style: AppTextStyles.textStyleRegular16.copyWith(
            color: AppColors.greyColor,
          ),
        ),
        const SizedBox(width: 16),
        Radio<String>(
          key: const Key('edit_profile_gender_male'),
          value: 'male',
          groupValue: groupValue,
          activeColor: AppColors.primaryColor,
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
        Text(
          l10n.male,
          style: AppTextStyles.textStyleRegular16.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
