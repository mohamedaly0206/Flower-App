import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArrivalEstimateWidget extends StatelessWidget {
  const ArrivalEstimateWidget({super.key, required this.estimatedArrivalTime});
  final DateTime estimatedArrivalTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final int firebaseEstimatedArrivalTime = FirebaseRemoteConfig.instance
        .getInt(AppStrings.firebaseDeliveryEstimatedArrivalsConfig);
    final DateTime updatedEstimatedTime = estimatedArrivalTime.add(
      Duration(minutes: firebaseEstimatedArrivalTime),
    );
    final formattedTime = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(updatedEstimatedTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.estimatedArrival,
          style: theme.textTheme.displayLarge?.copyWith(
            color: theme.colorScheme.onInverseSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(formattedTime, style: theme.textTheme.headlineMedium?.copyWith()),
      ],
    );
  }
}
