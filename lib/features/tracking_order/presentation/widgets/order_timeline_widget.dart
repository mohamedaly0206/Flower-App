import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTimelineWidget extends StatelessWidget {
  const OrderTimelineWidget({super.key, required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final steps = [
      {'title': 'Received your order', 'desc': ''},
      {'title': 'Preparing your order', 'desc': ''},
      {'title': 'Out for delivery', 'desc': ''},
      {'title': 'Delivered', 'desc': ''},
    ];

    int visualStep = 0;
    if (currentStep >= 1) visualStep = 1;
    if (currentStep >= 2) visualStep = 2;
    if (currentStep >= 4) visualStep = 3;

    return Column(
      children: List.generate(steps.length, (index) {
        final isCompleted = visualStep >= index;
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCompleted
                          ? theme.colorScheme.primary
                          : Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.colorScheme.primary,
                            ),
                          )
                        : null,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50,
                    color: isCompleted
                        ? theme.colorScheme.primary
                        : Colors.grey,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      steps[index]['title']!,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isCompleted)
                      Text(
                        DateFormat(
                          'dd MMM yyyy - hh:mm',
                        ).format(DateTime.now()), // Placeholder
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
