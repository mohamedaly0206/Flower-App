import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/intent/profile_intent.dart';
import 'package:flower_app/features/app_sections/profile/presentation/view_model/state/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class CustomProfileInfo extends StatelessWidget {
  final ProfileSuccess state;

  const CustomProfileInfo({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 42,
          backgroundColor: AppColors.secondaryColor,
          backgroundImage: state.photoUrl.isNotEmpty
              ? NetworkImage(state.photoUrl)
              : null,
          child: state.photoUrl.isEmpty
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
              state.name,
              textAlign: TextAlign.center,
              style: AppTextStyles.textStyleMedium18.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            InkWell(
              onTap: () {
                // context.push(AppRouterPaths.kEditProfileView);
                context.push(AppRouterPaths.kEditProfileView).then((_) {
                  context.read<ProfileCubit>().doIntent(
                    LoadUserProfileIntent(),
                  );
                });
              },
              child: SvgPicture.asset(Assets.icons.notoV1Pen),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          state.email,
          textAlign: TextAlign.center,
          style: AppTextStyles.textStyleRegular16.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
