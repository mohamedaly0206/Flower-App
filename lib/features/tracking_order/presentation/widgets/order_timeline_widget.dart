import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderTimelineWidget extends StatelessWidget {
  const OrderTimelineWidget({
    super.key,
    required this.currentStep,
    required this.updatedAt,
  });
  final DateTime updatedAt;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final formattedTime = DateFormat('dd MMM yyyy, hh:mm a').format(updatedAt);
    final theme = Theme.of(context);
    final steps = [
      {'title': localizations.orderReceived},
      {'title': localizations.orderPreparing},
      {'title': localizations.orderOutForDelivery},
      {'title': localizations.delivered},
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
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCompleted
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onInverseSurface,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? Container(
                            width: 12,
                            height: 12,
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
                        : theme.colorScheme.onInverseSurface,
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
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (isCompleted)
                      Text(
                        formattedTime, // Placeholder
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onInverseSurface,
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
