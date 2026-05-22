import 'package:flower_app/core/localization/app_locale_controller.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/intent/profile_intent.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String languageName(BuildContext context, String languageCode) {
  return languageCode == 'ar'
      ? AppLocalizations.of(context)!.arabic
      : AppLocalizations.of(context)!.english;
}

void showLanguageBottomSheet(
  BuildContext context, {
  required String selectedLanguageCode,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.whiteColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 64,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              AppLocalizations.of(context)!.changeLanguage,
              style: AppTextStyles.textStyleSemiBold20.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            _LanguageOption(
              title: AppLocalizations.of(context)!.arabic,
              isSelected: selectedLanguageCode == 'ar',
              onTap: () async {
                await context.read<ProfileCubit>().doIntent(
                  ChangeLanguageIntent('ar'),
                );
                if (context.mounted) {
                  AppLocaleScope.updateLocale(context, 'ar');
                }
                if (!sheetContext.mounted) return;
                Navigator.of(sheetContext).pop();
              },
            ),
            const SizedBox(height: 12),
            _LanguageOption(
              title: AppLocalizations.of(context)!.english,
              isSelected: selectedLanguageCode == 'en',
              onTap: () async {
                await context.read<ProfileCubit>().doIntent(
                  ChangeLanguageIntent('en'),
                );
                if (context.mounted) {
                  AppLocaleScope.updateLocale(context, 'en');
                }
                if (!sheetContext.mounted) return;
                Navigator.of(sheetContext).pop();
              },
            ),
            SizedBox(height: MediaQuery.paddingOf(sheetContext).bottom),
          ],
        ),
      );
    },
  );
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFEDEDED)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.textStyleMedium16.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: AppColors.primaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
