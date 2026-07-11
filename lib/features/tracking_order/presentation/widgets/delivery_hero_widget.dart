import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryHeroWidget extends StatelessWidget {
  const DeliveryHeroWidget({super.key, required this.driverName});

  final String driverName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.grey[200],
          child: SvgPicture.asset(
            Assets.icons.deliveryBoyIcon,
            width: 30,
            height: 30,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                driverName,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Is your delivery hero for today',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: SvgPicture.asset(Assets.icons.coloredCallIcon, width: 16),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(Assets.icons.whatsappIcon, width: 24),
          onPressed: () {},
        ),
      ],
    );
  }
}
