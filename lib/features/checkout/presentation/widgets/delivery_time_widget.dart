import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryTimeWidget extends StatelessWidget {
  const DeliveryTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    final int deliveryDays = FirebaseRemoteConfig.instance.getInt(
      AppStrings.firebaseDeliveryDaysConfig,
    );

    final DateTime targetDate = DateTime.now().add(
      Duration(days: deliveryDays),
    );
    final locale = Localizations.localeOf(context).languageCode;

    final String formattedDate = DateFormat(
      'dd MMM yyyy',
      locale,
    ).format(targetDate);

    final String deliveryTimeText =
        '${appLocalizations?.arriveBy} $formattedDate, ${appLocalizations?.deliveryClock}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations!.deliveryTime,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 20,
                color: theme.colorScheme.onSurface,
              ),
              const SizedBox(width: 8),
              Text(
                appLocalizations.instant,
                style: theme.textTheme.displayLarge,
              ),
              SizedBox(width: 4),
              Text(
                deliveryTimeText,
                style: theme.textTheme.displayLarge?.copyWith(
                  color: theme.colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
