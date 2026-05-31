import 'package:flower_app/core/widgets/address_widget.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/state/cart_state.dart';
import 'package:flower_app/features/app_sections/cart/presentation/widgets/cart_item.dart';
import 'package:flower_app/features/app_sections/cart/presentation/widgets/cart_checkout_prices.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    // 1. Target the AppBar title selectively.
    // context.select ensures the Scaffold only rebuilds when the itemCount actually changes.
    final itemCount = context.select<CartCubit, int>((cubit) =>
        cubit.state.getCartItemsState?.data?.numOfCartItems ?? 0);

    String appBarTitle = itemCount > 0
        ? '${appLocalizations.cart} ($itemCount ${appLocalizations.items})'
        : appLocalizations.cart;

    // 2. Use BlocListener strictly for side effects (like SnackBars)
    return BlocListener<CartCubit, CartState>(
      listenWhen: (previous, current) =>
          previous.removeItemFromCartState != current.removeItemFromCartState ||
          previous.updateItemQuantityInCartState != current.updateItemQuantityInCartState,
      listener: (context, state) {
        if (state.removeItemFromCartState?.errorMessage != null) {
          AppMessages.showError(
            context,
            message: state.removeItemFromCartState!.errorMessage!,
          );
        }
        if (state.updateItemQuantityInCartState?.errorMessage != null) {
          AppMessages.showError(
            context,
            message: state.updateItemQuantityInCartState!.errorMessage!,
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: appBarTitle, hasBackButton: false),
        // 3. Scope BlocBuilder strictly to the body and filter unnecessary rebuilds.
        body: BlocBuilder<CartCubit, CartState>(
          buildWhen: (previous, current) =>
              previous.getCartItemsState != current.getCartItemsState,
          builder: (context, state) {
            final theme = Theme.of(context);
            final getCartState = state.getCartItemsState;
            final cartResponse = getCartState?.data;
            final cartData = cartResponse?.cart;
            final cartItems = cartData?.cartItems ?? [];

            double subTotal = 0.0;
            for (var item in cartItems) {
              final price =
                  item.product?.priceAfterDiscount ?? item.product?.price ?? 0;
              final quantity = item.quantity ?? 1;
              subTotal += (price * quantity);
            }

            const deliveryFee = 10.0;
            final total = subTotal + deliveryFee;

            if (getCartState?.isLoading == true && cartItems.isEmpty) {
              return Center(
                child: SpinKitFadingCircle(
                  color: theme.colorScheme.primary,
                ),
              );
            }

            if (getCartState?.errorMessage != null && cartItems.isNotEmpty) {
              return Center(
                child: Text(
                  getCartState!.errorMessage ?? appLocalizations.errorMessage,
                  style: theme.textTheme.displayLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (cartItems.isEmpty) {
              return Center(
                child: Text(
                  appLocalizations.emptyCart,
                  style: theme.textTheme.displayLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const AddressWidget(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        final product = item.product;

                        return CartItem(
                          productId: product?.id ?? '',
                          title: product?.title ?? '',
                          subtitle: product?.description ?? '',
                          imageUrl: product?.imageCover ?? '',
                          price: product?.priceAfterDiscount ?? 0,
                          quantity: item.quantity ?? 0,
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16, bottom: 30),
                    child: Column(
                      children: [
                        CartCheckoutPrices(
                          title: appLocalizations.subTotal,
                          value: '$subTotal\$',
                        ),
                        const SizedBox(height: 12),
                        CartCheckoutPrices(
                          title: appLocalizations.deliveryFee,
                          value: '$deliveryFee\$',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Divider(thickness: 1, height: 1),
                        ),
                        CartCheckoutPrices(
                          title: appLocalizations.total,
                          value: '$total\$',
                          isTotal: true,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(appLocalizations.checkout),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}