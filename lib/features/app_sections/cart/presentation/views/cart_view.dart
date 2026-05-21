import 'package:flower_app/core/widgets/address_widget.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/app_sections/cart/presentation/widgets/cart_item.dart';
import 'package:flower_app/features/app_sections/cart/presentation/widgets/checkout_totals.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  final int itemCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:
            '${AppLocalizations.of(context)!.cart} ($itemCount ${AppLocalizations.of(context)!.items})',
        hasBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const AddressWidget(),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) => const CartItem(),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 16, bottom: 30),
              child: Column(
                children: [
                  CheckoutTotals(
                    title: AppLocalizations.of(context)!.subTotal,
                    value: '100\$',
                  ),
                  const SizedBox(height: 12),
                  CheckoutTotals(
                    title: AppLocalizations.of(context)!.deliveryFee,
                    value: '10\$',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(thickness: 1, height: 1),
                  ),
                  CheckoutTotals(
                    title: AppLocalizations.of(context)!.total,
                    value: '110\$',
                    isTotal: true,
                  ),
                  const SizedBox(height: 24),

                  // Checkout Button
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context)!.checkout),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
