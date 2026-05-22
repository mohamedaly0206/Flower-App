import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../l10n/app_localizations.dart';
import '../values/assets.gen.dart';

class CustomProductCard extends StatelessWidget {
  final String? title;
  final ImageProvider imageProvider;
  final int? price;
  final int? oldPrice;
  final int? discountPercent;
  final VoidCallback? onTap;
  final String? currency;
  final String? productId;

  const CustomProductCard({
    required this.title,
    required this.imageProvider,
    required this.price,
    super.key,
    required this.oldPrice,
    required this.discountPercent,
    required this.onTap,
    this.currency = 'EGP',
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.egp} $price',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '$oldPrice',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${discountPercent ?? 0}%',
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
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  int quantity = 0;
                  context.read<CartCubit>().cartIntentHandler(
                    AddItemToCartIntent(
                      request: AddToCartRequest(
                        productId: productId!,
                        quantity: ++quantity,
                      ),
                    ),
                  );
                },
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
                      AppLocalizations.of(context)!.addToCart,
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
      ),
    );
  }
}
