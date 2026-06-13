import 'package:flower_app/core/shared_features/shared_view_model/cubit/home_shared_cubit.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key, required this.cubit});

  final HomeSharedCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      width: 101,
      child: FloatingActionButton.extended(
        onPressed: () => cubit.openFilterBottomSheet(context),
        elevation: 4,
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        icon: SvgPicture.asset(
          Assets.icons.tuneIcon,
          width: 20,
          colorFilter: const ColorFilter.mode(
            AppColors.whiteColor,
            BlendMode.srcIn,
          ),
        ),
        label: Padding(
          padding: EdgeInsets.only(right: 4),
          child: Text(
            AppLocalizations.of(context)!.filter,
            style: AppTextStyles.textStyleMedium16.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}