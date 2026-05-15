import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/values/app_strings.dart';

class OccasionListViewItem extends StatelessWidget {
  const OccasionListViewItem({super.key});

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
        Text(
          AppStrings.addNewAddress,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          AppStrings.addNew,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
