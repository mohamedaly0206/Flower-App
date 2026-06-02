import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String id;
  final String title;
  final String address;
  const AddressCard({
    super.key,
    required this.id,
    required this.title,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
                      // isSelected
                      //     ? Icons.radio_button_checked
                      //     :
                      Icons.radio_button_unchecked,
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
          Image.asset(Assets.icons.editPencil.path, width: 18, height: 18),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
