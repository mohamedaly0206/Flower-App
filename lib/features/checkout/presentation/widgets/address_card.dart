import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/intent/checkout_intent.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCard extends StatelessWidget {
  final String id;
  final String title;
  final String address;
  final CheckoutState state;
  const AddressCard({
    super.key,
    required this.id,
    required this.title,
    required this.address,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected =
        state.selectedAddressId == id; // Replace with actual selection logic
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        context.read<CheckoutCubit>().handleCheckoutIntent(
          SelectDeliveryAddressIntent(addressId: id),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.102,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onTertiaryFixedVariant.withValues(
                alpha: 0.1,
              ),
              spreadRadius: 0.3,
              blurRadius: 8,
              offset: const Offset(4, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color:
                            // isSelected ? Colors.pink :
                            theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(title, style: theme.textTheme.headlineMedium),
                    ],
                  ),
                  Text(address, style: theme.textTheme.headlineSmall),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Navigate to edit address screen
              },
              child: Image.asset(
                Assets.icons.editPencil.path,
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
