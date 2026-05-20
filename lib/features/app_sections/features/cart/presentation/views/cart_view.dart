import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/core/widgets/address_widget.dart';
import 'package:flower_app/core/widgets/custom_app_bar.dart';
import 'package:flower_app/features/app_sections/features/cart/presentation/widgets/cart_item.dart';
import 'package:flower_app/features/app_sections/features/cart/presentation/widgets/checkout_totals.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  final int itemCount = 5; // Example item count, replace with actual data in real implementation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '${AppStrings.cart} ($itemCount items)',
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
                    title: 'Sub Total',
                    value: '100\$',
                  ),
                  const SizedBox(height: 12),
                  CheckoutTotals(
                    title: 'Delivery Fee',
                    value: '10\$',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(thickness: 1, height: 1),
                  ),
                  CheckoutTotals(
                    title: 'Total',
                    value: '110\$',
                    isTotal: true,
                  ),
                  const SizedBox(height: 24),

                  // Checkout Button
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: Text('Checkout'),
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

  // Helper widget to generate the rows for the summary
}

