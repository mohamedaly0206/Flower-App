import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final String? actionText;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onPressed,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            actionText ?? AppLocalizations.of(context)!.viewAll,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              decoration: TextDecoration.underline,
              decorationColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
