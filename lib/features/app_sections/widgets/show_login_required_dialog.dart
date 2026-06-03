import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showLoginRequiredDialog(BuildContext context, String message) {
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
                message,
                style: AppTextStyles.textStyleMedium16.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                        foregroundColor: AppColors.greyColor,
                        side: BorderSide(color: AppColors.greyColor),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: AppTextStyles.textStyleSemiBold12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        context.go(AppRouterPaths.kLoginView);
                      },
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        AppLocalizations.of(context)!.loginNow,
                        style: AppTextStyles.textStyleSemiBold12,
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
