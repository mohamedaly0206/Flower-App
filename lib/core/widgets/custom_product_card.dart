
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../values/assets.gen.dart';

class CustomProductCard extends StatelessWidget {
  // final String title;
  // final ImageProvider imageProvider;
  // final num price;
  // final num? oldPrice;
  // final int? discountPercent;
  // final VoidCallback? onAddToCart;
  // final VoidCallback? onTap;
  // final String currency;

  const CustomProductCard({super.key}
  //   {
  //   // required this.title,
  //   // required this.imageProvider,
  //   // required this.price,
  //   // super.key,
  //   // this.oldPrice,
  //   // this.discountPercent,
  //   // this.onAddToCart,
  //   // this.onTap,
  //   // this.currency = 'EGP',
  // }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onTertiaryFixed,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Image.network(
                'https://thumbs.dreamstime.com/b/pink-white-dahlia-flower-soft-petals-garden-background-vibrant-441563444.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('flower', style: Theme.of(context).textTheme.bodySmall),
                  SizedBox(height: 4),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'EGP 600',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Spacer(),

                        Text(
                          '800',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '25%',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 30),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.icons.shoppingCartIcon,
                    width: 15,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Add to cart',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
