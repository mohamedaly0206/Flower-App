import 'package:flower_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/intent/checkout_intent.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsCard extends StatelessWidget {
  const PaymentMethodsCard({
    super.key,
    required this.method,
    required this.title,
    required this.state,
  });
  final PaymentMethod method;
  final String title;
  final CheckoutState state;

  @override
  Widget build(BuildContext context) {
    final isSelected = state.selectedPaymentMethod == method;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.read<CheckoutCubit>().handleCheckoutIntent(
                SelectPaymentMethodIntent(paymentMethod: method),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onTertiaryFixedVariant.withValues(
                      alpha: 0.1,
                    ), // Shadow color
                    spreadRadius: 0.3, // Extends the shadow radius
                    blurRadius: 8, // Blurs the edges of the shadow
                    offset: const Offset(4, 4), // Moves shadow position (x, y)
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(title, style: theme.textTheme.bodyLarge),
                  ),
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: theme.colorScheme.primary,
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
