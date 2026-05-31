import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItem extends StatelessWidget {
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
                image: CachedNetworkImageProvider(imageUrl),
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
                          title,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // --- DELETE BUTTON ---
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          // Check global state if THIS item is being deleted
                          final isDeleteLoading =
                              state.deletingProductIds.contains(productId);

                          return InkWell(
                            onTap: isDeleteLoading
                                ? null // Disable tap while loading
                                : () {
                                    context.read<CartCubit>().cartIntentHandler(
                                          RemoveItemFromCartIntent(
                                            productId: productId,
                                          ),
                                        );
                                  },
                            child: isDeleteLoading
                                ? SpinKitFadingCircle(
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 20,
                                  )
                                : SvgPicture.asset(
                                    Assets.icons.deleteIcon,
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.error,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Subtitle
                  Text(
                    subtitle,
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
                        '\$${price.toInt()}',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      // --- QUANTITY CONTROLS ---
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                          // Check global state if THIS item's quantity is updating
                          final isQuantityLoading =
                              state.updatingProductIds.contains(productId);

                          return Row(
                            children: [
                              CountItem(
                                onTap: () {
                                  if (quantity > 1 && !isQuantityLoading) {
                                    context.read<CartCubit>().cartIntentHandler(
                                          UpdateCartItemQuantityIntent(
                                            productId: productId,
                                            quantity: UpdateCartQuantityRequest(
                                              quantity: quantity - 1,
                                            ),
                                          ),
                                        );
                                  }
                                },
                                iconPath: Assets.icons.removeIcon,
                              ),
                              const SizedBox(width: 4),
                              isQuantityLoading
                                  ? SpinKitFadingCircle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 15,
                                    )
                                  : Text(
                                      quantity.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                              const SizedBox(width: 4),
                              CountItem(
                                onTap: isQuantityLoading
                                    ? () {}
                                    : () {
                                        context
                                            .read<CartCubit>()
                                            .cartIntentHandler(
                                              UpdateCartItemQuantityIntent(
                                                productId: productId,
                                                quantity:
                                                    UpdateCartQuantityRequest(
                                                  quantity: quantity + 1,
                                                ),
                                              ),
                                            );
                                      },
                                iconPath: Assets.icons.addIcon,
                              ),
                            ],
                          );
                        },
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