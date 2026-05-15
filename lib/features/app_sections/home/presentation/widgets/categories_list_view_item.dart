import 'package:flutter/material.dart';

import '../../../../../core/values/app_strings.dart';

class CategoriesListViewItem extends StatelessWidget {
  const CategoriesListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.credit_card,
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.categories,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
