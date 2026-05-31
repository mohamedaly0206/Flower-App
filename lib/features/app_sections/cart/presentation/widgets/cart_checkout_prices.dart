import 'package:flutter/material.dart';

class CartCheckoutPrices extends StatelessWidget {
  const CartCheckoutPrices({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  final String title;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal == true
              ? theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                )
              : theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onTertiaryFixed,
                ),
        ),
        Text(
          value,
          style: isTotal == true
              ? theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                )
              : theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onTertiaryFixed,
                ),
        ),
      ],
    );
  }
}
