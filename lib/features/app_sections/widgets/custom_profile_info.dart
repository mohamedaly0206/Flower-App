import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/intent/profile_intent.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/state/profile_states.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CustomProfileInfo extends StatelessWidget {
  final ProfileSuccess? state;
  final bool isGuest;
  const CustomProfileInfo({
    super.key,
    required this.state,
    this.isGuest = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto = !isGuest && state != null && state!.photoUrl.isNotEmpty;
    final displayName = isGuest
        ? AppLocalizations.of(context)!.guestUser
        : (state?.name ?? '');
    final displayEmail = isGuest
        ? AppLocalizations.of(context)!.signIntoexploremore
        : (state?.email ?? '');
    return Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: AppColors.secondaryColor,
          backgroundImage: hasPhoto ? NetworkImage(state!.photoUrl) : null,
          child: !hasPhoto
              ? const Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                  size: 42,
                )
              : null,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              displayName,
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyleMedium18.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            if (!isGuest) ...[
              const SizedBox(width: 4),
              InkWell(
                onTap: () {
                  context.push(AppRouterPaths.kEditProfileView).then((_) {
                    context.read<ProfileCubit>().doIntent(
                      LoadUserProfileIntent(),
                    );
                  });
                },
                child: SvgPicture.asset(Assets.icons.notePen),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          displayEmail,
          textAlign: TextAlign.center,
          style: AppTextStyles.textStyleRegular16.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
