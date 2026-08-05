import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/state/profile_states.dart';
import 'package:flower_app/features/app_sections/widgets/custom_guest.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_header.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_info.dart';
import 'package:flower_app/features/app_sections/widgets/custom_profile_menu_tile.dart';
import 'package:flower_app/features/app_sections/widgets/profile_language_bottom_sheet.dart';
import 'package:flower_app/features/app_sections/widgets/profile_logout_dialog.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view/user_addresses_view.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/models/web_view_args.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getIt<FlutterSecureStorage>().read(key: 'token'),
      builder: (context, tokenSnapshot) {
        // 1. Handle Loading State
        if (tokenSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50,
              ),
            ),
          );
        }

        // 2. Handle Guest State
        final isGuest = tokenSnapshot.data == 'GUEST';
        if (isGuest) {
          return const CustomGuest();
        }

        // 3. Handle Authenticated User State
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is LogoutSuccess && context.mounted) {
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
                        icon: SvgPicture.asset(Assets.icons.addIcon),
                        title: AppLocalizations.of(context)!.myOrders,
                        onTap: () {
                          GoRouter.of(context).push(AppRouterPaths.kOrdersView);
                        },
                      ),
                      CustomProfileMenuTile(
                        icon: SvgPicture.asset(Assets.icons.locationIcon),
                        title: AppLocalizations.of(context)!.savedAddress,
                        onTap: () {
                          final cubit = getIt<UserAddressesCubit>();
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BlocProvider.value(
                                value: cubit,
                                child: const UserAddressesView(),
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(color: AppColors.placeHolderColor),
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
                      const Divider(color: AppColors.placeHolderColor),
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
                        onTap: () {
                          GoRouter.of(context).push(
                            AppRouterPaths.kWebView,
                            extra: WebViewArgs(
                              url: ApiEndpoints.aboutUs,
                              title: AppLocalizations.of(context)!.aboutUs,
                            ),
                          );
                        },
                      ),
                      CustomProfileMenuTile(
                        title: AppLocalizations.of(context)!.termsAndConditions,
                        onTap: () {
                          GoRouter.of(context).push(
                            AppRouterPaths.kWebView,
                            extra: WebViewArgs(
                              url: ApiEndpoints.termsAndConditions,
                              title: AppLocalizations.of(
                                context,
                              )!.termsAndConditions,
                            ),
                          );
                        },
                      ),
                      const Divider(color: AppColors.placeHolderColor),
                      CustomProfileMenuTile(
                        icon: SvgPicture.asset(Assets.icons.logoutIcon),
                        title: AppLocalizations.of(context)!.logout,
                        trailing: SvgPicture.asset(Assets.icons.logoutIcon),
                        onTap: () => showLogoutDialog(context),
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

            // Fallback loading state while cubit processes
            return Scaffold(
              body: Center(
                child: SpinKitFadingCircle(
                  color: Theme.of(context).colorScheme.primary,
                  size: 50,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
