import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const AddressCard({
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
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.placeHolderColor.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.locationIcon,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.blackColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    address.city!,
                    style: AppTextStyles.textStyleMedium14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: onDelete,
                    child: SvgPicture.asset(
                      Assets.icons.deleteIcon,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.errorColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: onEdit,
                    child: SvgPicture.asset(
                      Assets.icons.notePen,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.greyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            address.street ?? '',
            style: AppTextStyles.textStyleMedium14.copyWith(
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
