import 'package:flower_app/core/router/router_paths.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/core/values/app_strings.dart';
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
  final GlobalKey<FormState> giftFormKey;
  const PricesCheckoutWidget({
    super.key,
    required this.giftFormKey,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final checkoutCubit = context.read<CheckoutCubit>();
    final userAddressesState = context.watch<UserAddressesCubit>().state;
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
              } else if (state.checkoutCreditState.errorMessage != null) {
                AppMessages.showError(
                  context,
                  message: state.checkoutCreditState.errorMessage!,
                );
              } else if (state.checkoutCreditState.data != null) {
                final String paymentUrl =
                    state.checkoutCreditState.data.session?.url;
                final String successUrl =
                    state.checkoutCreditState.data.session?.successUrl;
                final String cancelUrl =
                    state.checkoutCreditState.data.session?.cancelUrl;

                GoRouter.of(context)
                    .push<bool?>(
                      // Expect a boolean result
                      AppRouterPaths.kCreditCardWebView,
                      extra: {
                        AppStrings.initialUrl: paymentUrl,
                        AppStrings.successUrl: successUrl,
                        AppStrings.cancelUrl: cancelUrl,
                      },
                    )
                    .then((isSuccess) {
                      if (!context.mounted) return;
                      checkoutCubit.handleCheckoutIntent(
                        ResetCreditStateIntent(),
                      );

                      if (isSuccess == true) {
                        AppMessages.showSuccess(
                          context,
                          message: appLocalizations.orderPlacedSuccessfully,
                        );

                        context.read<CartCubit>().cartIntentHandler(
                          ClearCartAfterCheckoutIntent(),
                        );

                        GoRouter.of(
                          context,
                        ).go(AppRouterPaths.kAppSections, extra: 2);
                      } else if (isSuccess == false) {
                        AppMessages.showError(
                          context,
                          message: appLocalizations.creditCardPaymentFailed,
                        );
                      }
                    });
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      (state.checkoutCashState.isLoading ||
                          state.checkoutCreditState.isLoading)
                      ? null
                      : () {
                          final selectedAddress = userAddressesState.addresses
                              .firstWhere(
                                (addr) => addr.id == state.selectedAddressId,
                                orElse: () =>
                                    userAddressesState.addresses.first,
                              );
                          final CheckoutRequest checkoutRequest =
                              CheckoutRequest(
                                shippingAddress: ShippingAddress(
                                  street: selectedAddress.street ?? '',
                                  phone:
                                      selectedAddress.phone ??
                                      userAddressesState.phone,
                                  city: selectedAddress.city ?? '',
                                  lat: selectedAddress.lat ?? '',
                                  long: selectedAddress.long ?? '',
                                ),
                              );
                          if (state.selectedPaymentMethod != null &&
                              state.selectedAddressId != null &&
                              state.selectedPaymentMethod ==
                                  PaymentMethod.creditCard &&
                              state.isGift == false) {
                            checkoutCubit.handleCheckoutIntent(
                              PlaceCreditCardOrderIntent(
                                checkoutRequest: checkoutRequest,
                              ),
                            );
                          }
                          if (state.selectedPaymentMethod != null &&
                              state.selectedAddressId != null &&
                              state.selectedPaymentMethod ==
                                  PaymentMethod.creditCard &&
                              state.isGift == true &&
                              giftFormKey.currentState!.validate()) {
                            checkoutCubit.handleCheckoutIntent(
                              PlaceCreditCardOrderIntent(
                                checkoutRequest: checkoutRequest,
                              ),
                            );
                          }
                          if (state.selectedPaymentMethod != null &&
                              state.selectedAddressId != null &&
                              state.selectedPaymentMethod ==
                                  PaymentMethod.cashOnDelivery) {
                            checkoutCubit.handleCheckoutIntent(
                              PlaceCashOrderIntent(
                                checkoutRequest: checkoutRequest,
                              ),
                            );
                          } else if (state.selectedPaymentMethod == null ||
                              state.selectedAddressId == null) {
                            AppMessages.showError(
                              context,
                              message: appLocalizations
                                  .noPaymentMethodOrAddressSelected,
                            );
                          }
                        },

                  child:
                      state.checkoutCashState.isLoading ||
                          state.checkoutCreditState.isLoading
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
