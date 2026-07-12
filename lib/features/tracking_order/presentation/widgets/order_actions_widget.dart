import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OrderActionsWidget extends StatelessWidget {
  const OrderActionsWidget({
    super.key,
    required this.status,
    required this.onOrderDelivered,
  });

  final String status;
  final VoidCallback onOrderDelivered;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: Text(localizations.showMap),
          ),
        ),
        if (status == localizations.delivered) ...[
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: onOrderDelivered,
              child: Text(localizations.orderDelivered),
            ),
          ),
        ],
      ],
    );
  }
}
