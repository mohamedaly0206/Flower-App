import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/state/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../l10n/app_localizations.dart';
import '../values/assets.gen.dart';

class CustomProductCard extends StatefulWidget {
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
  State<CustomProductCard> createState() => _CustomProductCardState();
}

class _CustomProductCardState extends State<CustomProductCard> {
  // Two-step tracking state machine to prevent premature resets
  bool _isWaitingToStart = false;
  bool _isThisItemLoading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
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
                  image: widget.imageProvider,
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
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title ?? '',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.egp} ${widget.price}',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.oldPrice}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.discountPercent ?? 0}%',
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
            const SizedBox(height: 8),
            BlocConsumer<CartCubit, CartState>(
              listener: (context, state) {
                final cartState = state.addItemToCartState;
                if (cartState == null) return;

                if (_isWaitingToStart && cartState.isLoading == true) {
                  setState(() {
                    _isWaitingToStart = false;
                    _isThisItemLoading = true;
                  });
                }

                if (_isThisItemLoading && cartState.isLoading == false) {
                  if (cartState.data != null) {
                    AppMessages.showSuccess(
                      context,
                      message: AppLocalizations.of(context)!.successAddToCart,
                    );
                  }
                  if (cartState.errorMessage != null) {
                    AppMessages.showError(
                      context,
                      message: cartState.errorMessage!,
                    );
                  }

                  setState(() {
                    _isThisItemLoading = false;
                  });
                }
              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      setState(() {
                        _isWaitingToStart = true;
                        _isThisItemLoading = false;
                      });

                      int quantity = 0;
                      context.read<CartCubit>().cartIntentHandler(
                        AddItemToCartIntent(
                          request: AddToCartRequest(
                            productId: widget.productId!,
                            quantity: ++quantity,
                          ),
                        ),
                      );
                    },
                    // Depend cleanly on the confirmed local loading flag
                    child: _isThisItemLoading
                        ? SpinKitFadingCircle(
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20,
                          )
                        : Row(
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
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.addToCart,
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
