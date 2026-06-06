import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/widgets/app_messages.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flower_app/features/app_sections/cart/presentation/widgets/cart_checkout_prices.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/data/models/request/shipping_address_dto.dart';
import 'package:flower_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/intent/checkout_intent.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class PricesCheckoutWidget extends StatelessWidget {
  final double subTotal;
  final double deliveryFee;
  final double total;
  const PricesCheckoutWidget({
    super.key,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          CartCheckoutPrices(
            title: appLocalizations!.subTotal,
            value: '$subTotal \$',
          ),
          const SizedBox(height: 12),
          CartCheckoutPrices(
            title: appLocalizations.deliveryFee,
            value: '$deliveryFee \$',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(thickness: 1, height: 1),
          ),
          CartCheckoutPrices(
            title: appLocalizations.total,
            value: '$total \$',
            isTotal: true,
          ),
          const SizedBox(height: 24),

          BlocConsumer<CheckoutCubit, CheckoutState>(
            listener: (BuildContext context, CheckoutState state) {
              if (state.checkoutCashState.data != null) {
                AppMessages.showSuccess(
                  context,
                  message: appLocalizations.orderPlacedSuccessfully,
                );

                context.read<CartCubit>().cartIntentHandler(
                  ClearCartAfterCheckoutIntent(),
                );
                GoRouter.of(context).go(AppRouterPaths.kAppSections, extra: 2);
              } else if (state.checkoutCashState.errorMessage != null) {
                AppMessages.showError(
                  context,
                  message: state.checkoutCashState.errorMessage!,
                );
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final CheckoutRequest checkoutRequest = CheckoutRequest(
                      shippingAddress: ShippingAddress(
                        street: 'salah Salem St', // Replace with actual data
                        phone: '0123456789', // Replace with actual data
                        city: 'Cairo', // Replace with actual data
                        lat: '30.0444', // Replace with actual data
                        long: '31.2357', // Replace with actual data
                      ),
                    );
                    if (state.selectedPaymentMethod != null &&
                        state.selectedAddressId != null) {
                      context.read<CheckoutCubit>().handleCheckoutIntent(
                        PlaceCashOrderIntent(checkoutRequest: checkoutRequest),
                      );
                    } else {
                      AppMessages.showError(
                        context,
                        message:
                            appLocalizations.noPaymentMethodOrAddressSelected,
                      );
                    }
                  },

                  child: state.checkoutCashState.isLoading
                      ? SpinKitFadingCircle(
                          color: theme.colorScheme.secondary,
                          size: 24,
                        )
                      : Text(appLocalizations.placeOrder),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
