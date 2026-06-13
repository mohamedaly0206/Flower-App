import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_text_styles.dart';
import 'package:flutter_svg/svg.dart';
import 'product_sort_type.dart';

void showProductSortBottomSheet(
  BuildContext context, {
  required ProductSortType currentSortType,
  required ValueChanged<ProductSortType> onSortSelected,
}) {
  ProductSortType tempSelectedType = currentSortType;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.whiteColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.61,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 80,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.sortBy,
                    style: AppTextStyles.textStyleSemiBold20.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  StatefulBuilder(
                    builder: (context, setSheetState) {
                      Widget buildSortOption(
                        String title,
                        ProductSortType type,
                      ) {
                        final isSelected = tempSelectedType == type;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.placeHolderColor.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 10,
                                spreadRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              title,
                              style: AppTextStyles.textStyleMedium18.copyWith(
                                color: AppColors.blackColor,
                              ),
                            ),
                            trailing: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            onTap: () {
                              setSheetState(() {
                                tempSelectedType = type;
                              });
                            },
                          ),
                        );
                      }

                      return Column(
                        children: [
                          buildSortOption(
                            AppLocalizations.of(context)!.lowesPrice,
                            ProductSortType.lowestPrice,
                          ),
                          buildSortOption(
                            AppLocalizations.of(context)!.highestPrice,
                            ProductSortType.highestPrice,
                          ),
                          buildSortOption(
                            AppLocalizations.of(context)!.newProduct,
                            ProductSortType.newest,
                          ),
                          buildSortOption(
                            AppLocalizations.of(context)!.old,
                            ProductSortType.oldest,
                          ),
                          buildSortOption(
                            AppLocalizations.of(context)!.discount,
                            ProductSortType.discount,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                onSortSelected(tempSelectedType);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                              ),
                              icon: SvgPicture.asset(
                                Assets.icons.tuneIcon,
                                width: 20,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.whiteColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              label: Text(
                                AppLocalizations.of(context)!.filter,
                                style: AppTextStyles.textStyleMedium16.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
