import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAddressCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const UserAddressCard({
    super.key,
    required this.address,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.placeHolderColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            Assets.icons.locationIcon,
            width: 22,
            height: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.city ?? '',
                  style: AppTextStyles.textStyleMedium16.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address.street ?? '',
                  style: AppTextStyles.textStyleMedium14.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onDelete,
            child: SvgPicture.asset(
              Assets.icons.deleteIcon,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.errorColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: onEdit,
            child: SvgPicture.asset(
              Assets.icons.notePen,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                AppColors.greyColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
