import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryHeroWidget extends StatelessWidget {
  const DeliveryHeroWidget({super.key, required this.driverName});

  final String driverName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: theme.colorScheme.onPrimary,
          child: SvgPicture.asset(
            Assets.icons.deliveryBoyIcon,
            width: 36,
            height: 36,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(driverName, style: theme.textTheme.displayLarge),
              Text(
                localizations.deliveryHeroToday,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onInverseSurface,
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
