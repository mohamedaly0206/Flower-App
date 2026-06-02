import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/checkout/presentation/widgets/address_card.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            appLocalizations!.deliveryAddress,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          AddressCard(
            id: 'home',
            title: 'Home',
            address: '2XVP+XC - Sheikh Zayed',
          ),
          const SizedBox(height: 8),
          AddressCard(
            id: 'office',
            title: 'Office',
            address: '2XVP+XC - Sheikh Zayed',
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Navigate to add address screen
            },
            style: ElevatedButton.styleFrom().copyWith(
              backgroundColor: WidgetStateProperty.all(
                theme.colorScheme.onPrimary,
              ),
              side: WidgetStateProperty.all(
                BorderSide(color: theme.colorScheme.onTertiaryFixed),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.icons.addIcon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  appLocalizations.addNewAddress,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
