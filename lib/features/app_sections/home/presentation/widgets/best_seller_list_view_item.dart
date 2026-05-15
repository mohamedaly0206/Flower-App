import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class BestSellerListViewItem extends StatelessWidget {
  const BestSellerListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          width: 130,
          height: 150,
          fit: BoxFit.cover,
          imageUrl:
              'https://hips.hearstapps.com/hmg-prod/images/gettyimages-2165950545-69600af8c9b0d.jpg?crop=0.667xw:1.00xh;0.112xw,0&resize=1200:*',
        ),
        const SizedBox(height: 8),
        Text(AppStrings.addNewAddress, style: Theme.of(context).textTheme.bodyMedium),
        Text(
          AppStrings.pricesIncludedTax,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
