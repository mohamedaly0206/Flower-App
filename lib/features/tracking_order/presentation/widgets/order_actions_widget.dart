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
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Show map',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        if (status == 'delivered') ...[
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: onOrderDelivered,
              child: const Text(
                'Order Delivered',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
