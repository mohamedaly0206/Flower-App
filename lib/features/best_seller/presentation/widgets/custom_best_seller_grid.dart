import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/widgets/custom_product_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared_features/products/domain/entities/product_entity.dart';

class CustomBestSellerGrid extends StatelessWidget {
  final List<ProductEntity>? bestSellers;

  const CustomBestSellerGrid({super.key, required this.bestSellers});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.62,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: bestSellers?.length,
      itemBuilder: (context, index) {
        final product = bestSellers?[index];

        return CustomProductCard(
          imageProvider: CachedNetworkImageProvider(product!.imageCover ?? ''),
          price: product.priceAfterDiscount,
          title: product.title,
          discountPercent: product.discount,
          oldPrice: product.price,
          onTap: () {
            GoRouter.of(
              context,
            ).push(AppRouterPaths.kProductDetailsView, extra: product);
          },
          productId: product.id,
        );
      },
    );
  }
}
