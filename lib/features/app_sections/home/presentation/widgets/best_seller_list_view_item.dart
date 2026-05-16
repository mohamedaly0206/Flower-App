import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class BestSellerListViewItem extends StatelessWidget {
  const BestSellerListViewItem({super.key, required this.bestSeller});

  final ProductEntity bestSeller;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: 130,
            height: 150,
            fit: BoxFit.cover,
            imageUrl: bestSeller.imageCover ?? '',
          ),

          const SizedBox(height: 8),

          Text(
            bestSeller.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '${bestSeller.price} EGP',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
