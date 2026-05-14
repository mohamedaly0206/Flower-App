import 'package:flower_app/core/widgets/custom_product_card.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_model.dart';
import 'package:flutter/material.dart';

class CustomBestSellerGrid extends StatelessWidget {
  final List<BestSellerModel> bestSellers;

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
      itemCount: bestSellers.length,
      itemBuilder: (context, index) {
        final product = bestSellers[index];
        final hasDiscount =
            product.discount > 0 && product.priceAfterDiscount < product.price;

        return CustomProductCard(
          imageUrl: product.imgCover ?? '',
          price: product.priceAfterDiscount,
          title: product.title,
          discountPercent: hasDiscount ? product.discount : null,
          oldPrice: hasDiscount ? product.price : null,
        );
      },
    );
  }
}
