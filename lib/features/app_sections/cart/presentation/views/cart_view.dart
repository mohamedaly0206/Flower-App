import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/app_sections/cart/presentation/widgets/cart_guest_placeholder.dart';
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return FutureBuilder<String?>(
      future: getIt<FlutterSecureStorage>().read(key: 'token'),
      builder: (context, tokenSnapshot) {
        if (tokenSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50,
              ),
            ),
          );
        }

        final isGuest = tokenSnapshot.data == 'GUEST';
        if (isGuest) {
          return const CartGuestPlaceholder();
        }

        final itemCount = context.select<CartCubit, int>(
          (cubit) => cubit.state.itemCount,
        );

        final appBarTitle = itemCount > 0
            ? '${appLocalizations.cart} ($itemCount ${appLocalizations.items})'
            : appLocalizations.cart;

        return BlocListener<CartCubit, CartState>(
          listenWhen: (previous, current) =>
              previous.removeItemFromCartState !=
                  current.removeItemFromCartState ||
              previous.updateItemQuantityInCartState !=
                  current.updateItemQuantityInCartState,
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
            body: BlocBuilder<CartCubit, CartState>(
              buildWhen: (previous, current) =>
                  previous.getCartItemsState != current.getCartItemsState,
              builder: (context, state) {
                if (state.getCartItemsState?.isLoading == true &&
                    state.isCartEmpty) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: theme.colorScheme.primary,
                    ),
                  );
                }

                if (state.getCartItemsState?.errorMessage != null &&
                    state.isCartEmpty) {
                  return Center(
                    child: Text(
                      state.getCartItemsState!.errorMessage ??
                          appLocalizations.errorMessage,
                      style: theme.textTheme.displayLarge!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state.isCartEmpty) {
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
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = state.cartItems[index];
                            final product = item.product;

                            return CartItem(
                              productId: product?.id ?? '',
                              title: product?.title ?? '',
                              subtitle: product?.description ?? '',
                              imageUrl: product?.imageCover ?? '',
                              price:
                                  product?.priceAfterDiscount ??
                                  product?.price ??
                                  0,
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
                              value: '${state.subTotal}\$',
                            ),
                            const SizedBox(height: 12),
                            CartCheckoutPrices(
                              title: appLocalizations.deliveryFee,
                              value: '${state.deliveryFee}\$',
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Divider(thickness: 1, height: 1),
                            ),
                            CartCheckoutPrices(
                              title: appLocalizations.total,
                              value: '${state.totalPrice}\$',
                              isTotal: true,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  final double subTotal = state.subTotal
                                      .toDouble();
                                  GoRouter.of(context).push(
                                    AppRouterPaths.kCheckoutView,
                                    extra: {
                                      'subTotal': subTotal,
                                      'deliveryFee': state.deliveryFee,
                                      'totalPrice': state.totalPrice,
                                    },
                                  );
                                },
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
      },
    );
  }
}
