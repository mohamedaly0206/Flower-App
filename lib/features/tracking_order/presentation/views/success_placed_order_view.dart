import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessPlacedOrderView extends StatelessWidget {
  const SuccessPlacedOrderView({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(flex: 2),
            SizedBox(
              width: 150,
              height: 150,
              child: SvgPicture.asset(Assets.icons.successDeliverdOrder),
            ),
            const SizedBox(height: 40),

            Text(
              localizations.orderPlacedSuccessfully,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              localizations.orderPlacedMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
