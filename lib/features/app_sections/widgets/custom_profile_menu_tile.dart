import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomProfileMenuTile extends StatelessWidget {
  final Widget? icon;
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CustomProfileMenuTile({
    super.key,
    this.icon,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final leadingWidget = leading ?? (icon ?? const SizedBox(width: 22));

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            Visibility(visible: icon != null, child: leadingWidget),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.textStyleRegular13.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.chevron_right,
                  size: 28,
                  color: AppColors.greyColor,
                ),
          ],
        ),
      ),
    );
  }
}
