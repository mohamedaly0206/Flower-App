import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/state/profile_states.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_header.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_info.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_menu_tile.dart';
import 'package:flower_app/features/app_sections/widgets/profile_language_bottom_sheet.dart';
import 'package:flower_app/features/app_sections/widgets/profile_logout_dialog.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CustomLogin extends StatelessWidget {
  final ProfileSuccess state;
  const CustomLogin({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const CustomProfileHeader(),
            const SizedBox(height: 15),
            CustomProfileInfo(state: state),
            const SizedBox(height: 15),
            CustomProfileMenuTile(
              icon: SvgPicture.asset(Assets.icons.transactionOrder),
              title: AppLocalizations.of(context)!.myOrders,
              onTap: () {
                GoRouter.of(context).push(AppRouterPaths.kOrdersView);
              },
            ),
            CustomProfileMenuTile(
              icon: SvgPicture.asset(Assets.icons.locationIcon),
              title: AppLocalizations.of(context)!.savedAddress,
              onTap: () {},
            ),
            Divider(color: AppColors.placeHolderColor),
            CustomProfileMenuTile(
              icon: Switch(
                value: true,
                activeThumbColor: AppColors.whiteColor,
                activeTrackColor: AppColors.primaryColor,
                inactiveThumbColor: AppColors.whiteColor,
                inactiveTrackColor: AppColors.placeHolderColor,
                onChanged: (_) {},
              ),
              title: AppLocalizations.of(context)!.notification,
              onTap: () {},
            ),
            Divider(color: AppColors.placeHolderColor),
            CustomProfileMenuTile(
              icon: SvgPicture.asset(Assets.icons.translateIcon),
              title: AppLocalizations.of(context)!.language,
              trailing: Text(
                languageName(context, state.languageCode),
                style: AppTextStyles.textStyleRegular12.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              onTap: () => showLanguageBottomSheet(
                context,
                selectedLanguageCode: state.languageCode,
              ),
            ),
            CustomProfileMenuTile(
              title: AppLocalizations.of(context)!.aboutUs,
              onTap: () {},
            ),
            CustomProfileMenuTile(
              title: AppLocalizations.of(context)!.termsAndConditions,
              onTap: () {},
            ),
            Divider(color: AppColors.placeHolderColor),
            CustomProfileMenuTile(
              icon: SvgPicture.asset(Assets.icons.logoutIcon),
              title: AppLocalizations.of(context)!.logout,
              trailing: SvgPicture.asset(Assets.icons.logoutIcon),
              onTap: () {
                if (!context.mounted) return;
                showLogoutDialog(context);
              },
            ),
            const SizedBox(height: 20),
            Text(
              'v 6.3.0 - (446)',
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyleRegular12.copyWith(
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
