import 'package:flower_app/features/app_sections/cart/presentation/widgets/cart_checkout_prices.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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

          // Place Order Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              // onPressed: state.status == CheckoutStatus.loading
              //     ? null
              //     : () => context.read<CheckoutCubit>().placeOrder(),
              // child: state.status == CheckoutStatus.loading
              //     ? const SpinKitFadingCircle(color: Colors.white, size: 24)
              child: Text(appLocalizations.placeOrder),
            ),
          ),
        ],
      ),
    );
  }
}
