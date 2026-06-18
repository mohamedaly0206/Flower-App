import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/intent/profile_intent.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showLogoutDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierColor: AppColors.blackColor.withValues(alpha: 0.45),
    builder: (dialogContext) {
      return Dialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(dialogContext)!.logout,
                style: AppTextStyles.textStyleMedium16.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(dialogContext)!.confirmLogout,
                style: AppTextStyles.textStyleRegular14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.greyColor,
                        backgroundColor: AppColors.whiteColor,
                        side: const BorderSide(color: AppColors.greyColor),
                      ),
                      child: Text(AppLocalizations.of(dialogContext)!.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        context.read<ProfileCubit>().doIntent(LogoutIntent());
                      },
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        AppLocalizations.of(dialogContext)!.logout,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
