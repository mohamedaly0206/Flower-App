import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../values/assets.gen.dart';

class CustomProductCard extends StatelessWidget {
  final String title;
  final ImageProvider imageProvider;
  final num price;
  final num? oldPrice;
  final int? discountPercent;
  final VoidCallback? onAddToCart;
  final VoidCallback? onTap;
  final String currency;
  final BoxFit imageFit;

  const CustomProductCard({
    required this.title,
    required this.imageProvider,
    required this.price,
    super.key,
    this.oldPrice,
    this.discountPercent,
    this.onAddToCart,
    this.onTap,
    this.currency = 'EGP',
    this.imageFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.placeHolderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image(
                    image: imageProvider,
                    fit: imageFit,
                    width: double.infinity,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.secondaryColor,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.placeHolderColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.textStyleRegular12.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  _PriceRow(
                    currency: currency,
                    price: price,
                    oldPrice: oldPrice,
                    discountPercent: discountPercent,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.shoppingCartIcon,
                      color: AppColors.whiteColor,
                      height: 15,
                    ),
                    SizedBox(width: 8),
                    Text(
                      AppStrings.addToCart,
                      style: AppTextStyles.textStyleMedium13.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String currency;
  final num price;
  final num? oldPrice;
  final int? discountPercent;

  const _PriceRow({
    required this.currency,
    required this.price,
    required this.oldPrice,
    required this.discountPercent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Text(
            '$currency ${_formatPrice(price)}',
            style: AppTextStyles.textStyleMedium14.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          if (oldPrice != null) ...[
            const SizedBox(width: 8),
            Text(
              _formatPrice(oldPrice!),
              style: AppTextStyles.textStyleRegular12.copyWith(
                color: AppColors.greyColor,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
          if (discountPercent != null) ...[
            const SizedBox(width: 8),
            Text(
              '$discountPercent%',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textStyleRegular12.copyWith(
                color: AppColors.successColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatPrice(num value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }
}
