import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';

Future<bool> checkGuestAndShowDialog(BuildContext context) async {
  final token = await getIt<FlutterSecureStorage>().read(key: 'token');

  if (token == 'GUEST') {
    if (!context.mounted) return false;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.whiteColor,
          title: const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.primaryColor,
            size: 48,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.signInRequired,
                style: AppTextStyles.textStyleSemiBold20.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(
                  context,
                )!.pleaseSignInToAddItemstoyourcartandenjoyfullshoppingfeatures,
                textAlign: TextAlign.center,
                style: AppTextStyles.textStyleRegular16.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          foregroundColor: AppColors.greyColor,
                          side: BorderSide(color: AppColors.greyColor),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: AppTextStyles.textStyleSemiBold20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.go(AppRouterPaths.kLoginView);
                        },
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          AppLocalizations.of(context)!.signIn,
                          style: AppTextStyles.textStyleSemiBold20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    return true;
  }

  return false;
}
