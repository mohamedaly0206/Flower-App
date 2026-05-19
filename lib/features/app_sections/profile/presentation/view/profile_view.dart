import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/profile_cubit.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/profile_states.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_header.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_info.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.go(AppRouterPaths.kLoginView);
        }
      },
      builder: (context, state) {
        if (state is ProfileSuccess) {
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
                    title: AppStrings.myOrders,
                    onTap: () {},
                  ),
                  CustomProfileMenuTile(
                    icon: SvgPicture.asset(Assets.icons.locationIcon),
                    title: AppStrings.savedAddress,
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
                    title: AppStrings.notification,
                    onTap: () {},
                  ),
                  Divider(color: AppColors.placeHolderColor),
                  CustomProfileMenuTile(
                    icon: SvgPicture.asset(Assets.icons.translateIcon),
                    title: AppStrings.language,
                    trailing: Text(
                      AppStrings.english,
                      style: AppTextStyles.textStyleRegular12.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  CustomProfileMenuTile(
                    title: AppStrings.aboutUs,
                    onTap: () {},
                  ),
                  CustomProfileMenuTile(
                    title: AppStrings.termsAndConditions,
                    onTap: () {},
                  ),
                  Divider(color: AppColors.placeHolderColor),
                  CustomProfileMenuTile(
                    icon: SvgPicture.asset(Assets.icons.logoutIcon),
                    title: AppStrings.logout,
                    trailing: SvgPicture.asset(Assets.icons.logoutIcon),
                    onTap: () => _showLogoutDialog(context),
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

        if (state is ProfileError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

void _showLogoutDialog(BuildContext context) {
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
                'LOGOUT',
                style: AppTextStyles.textStyleMedium16.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.confirmLogout,
                style: AppTextStyles.textStyleRegular14.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.blackColor,
                        side: const BorderSide(color: AppColors.greyColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(AppStrings.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                        context.read<ProfileCubit>().logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text('Logout'),
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
