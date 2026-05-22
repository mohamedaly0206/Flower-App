import 'package:flower_app/core/widgets/address_widget.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/state/cart_state.dart';
import 'package:flower_app/features/app_sections/cart/presentation/widgets/cart_item.dart';
import 'package:flower_app/features/app_sections/cart/presentation/widgets/checkout_totals.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
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
      builder: (context, state) {
        final getCartState = state.getCartItemsState;
        final cartResponse = getCartState?.data;
        final cartData = cartResponse?.cart;
        final cartItems = cartData?.cartItems ?? [];
        final itemCount = cartResponse?.numOfCartItems ?? 0;
        double subTotal = 0.0;
        for (var item in cartItems) {
          final price =
              item.product?.priceAfterDiscount ?? item.product?.price ?? 0;
          final quantity = item.quantity ?? 1;
          subTotal += (price * quantity);
        }
        //if u need to get the subTotal from the cartResponse
        // final subTotal = cartData?.totalPriceAfterDiscount ?? 0.0;
        const deliveryFee = 10.0;
        final total = subTotal + deliveryFee;
        String appBarTitle = itemCount > 0
            ? '${AppLocalizations.of(context)!.cart} ($itemCount ${AppLocalizations.of(context)!.items})'
            : AppLocalizations.of(context)!.cart;

        return Scaffold(
          appBar: CustomAppBar(title: appBarTitle, hasBackButton: false),
          body: state.getCartItemsState!.isLoading && cartItems.isEmpty
              ? Center(
                  child: SpinKitFadingCircle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : state.getCartItemsState!.errorMessage != null &&
                    cartItems.isNotEmpty
              ? Center(
                  child: Text(
                    getCartState!.errorMessage ??
                        AppLocalizations.of(context)!.errorMessage,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : cartItems.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.emptyCart,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const AddressWidget(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: cartItems.isEmpty
                            ? Center(
                                child: Text(AppLocalizations.of(context)!.cart),
                              )
                            : ListView.builder(
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
                      if (cartItems.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.only(top: 16, bottom: 30),
                          child: Column(
                            children: [
                              CheckoutTotals(
                                title: AppLocalizations.of(context)!.subTotal,
                                value: '$subTotal\$',
                              ),
                              const SizedBox(height: 12),
                              CheckoutTotals(
                                title: AppLocalizations.of(
                                  context,
                                )!.deliveryFee,
                                value: '$deliveryFee\$',
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Divider(thickness: 1, height: 1),
                              ),
                              CheckoutTotals(
                                title: AppLocalizations.of(context)!.total,
                                value: '$total\$',
                                isTotal: true,
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    AppLocalizations.of(context)!.checkout,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
