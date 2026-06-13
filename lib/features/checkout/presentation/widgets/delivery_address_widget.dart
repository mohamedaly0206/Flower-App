import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flower_app/core/values/assets.gen.dart';
import 'package:flower_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flower_app/features/checkout/presentation/widgets/address_card.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DeliveryAddressWidget extends StatelessWidget {
  const DeliveryAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, checkoutState) {
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
              BlocBuilder<UserAddressesCubit, UserAddressesState>(
                builder: (context, addressState) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: addressState.addresses.length,
                    itemBuilder: (context, index) {
                      // Replace with actual address data
                      final addressId = addressState.addresses[index].id;
                      final addressTitle = addressState.addresses[index].street;
                      final addressDetails = addressState.addresses[index].city;
                      return Padding(
                        padding: index >= 0
                            ? const EdgeInsets.only(bottom: 16)
                            : EdgeInsets.zero,
                        child: AddressCard(
                          id: addressId ?? '',
                          title: addressTitle ?? '',
                          address: addressDetails ?? '',
                          isSelected:
                              checkoutState.selectedAddressId == addressId,
                        ),
                      );
                    },
                  );
                },
              ),
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
      },
    );
  }
}
