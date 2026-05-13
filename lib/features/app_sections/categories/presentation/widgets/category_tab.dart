import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.isSelected,
    required this.categoryName,
  });
  final bool isSelected;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onTertiaryFixed;

    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryName,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: color),
            ),
            const SizedBox(height: 8),
            Container(
              height: 3,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
