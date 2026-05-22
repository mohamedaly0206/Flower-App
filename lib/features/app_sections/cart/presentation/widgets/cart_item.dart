import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItem extends StatefulWidget {
  final String productId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final num price;
  final int quantity;
  const CartItem({
    super.key,
    required this.productId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onTertiaryFixed,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            height: 101,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.imageUrl),
                fit: BoxFit.cover,
                onError: (error, stackTrace) => Icon(
                  Icons.image_not_supported_outlined,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Item Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          context.read<CartCubit>().cartIntentHandler(
                            RemoveItemFromCartIntent(
                              productId: widget.productId,
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          Assets.icons.deleteIcon,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.error,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Subtitle
                  Text(
                    widget.subtitle,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.price.toInt()}',
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          CountItem(
                            onTap: () {
                              if (widget.quantity > 1) {
                                context.read<CartCubit>().cartIntentHandler(
                                  UpdateCartItemQuantityIntent(
                                    productId: widget.productId,
                                    quantity: UpdateCartQuantityRequest(
                                      quantity: widget.quantity - 1,
                                    ),
                                  ),
                                );
                              }
                            },
                            iconPath: Assets.icons.removeIcon,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.quantity.toString(),
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 4),
                          CountItem(
                            onTap: () {
                              context.read<CartCubit>().cartIntentHandler(
                                UpdateCartItemQuantityIntent(
                                  productId: widget.productId,
                                  quantity: UpdateCartQuantityRequest(
                                    quantity: widget.quantity + 1,
                                  ),
                                ),
                              );
                            },
                            iconPath: Assets.icons.addIcon,
                          ),
                        ],
                      ),
                    ],
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

class CountItem extends StatelessWidget {
  final void Function() onTap;
  final String iconPath;
  const CountItem({required this.onTap, required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        iconPath,
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
