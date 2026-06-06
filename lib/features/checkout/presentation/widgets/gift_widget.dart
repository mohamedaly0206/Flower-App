import 'package:flower_app/core/utilities/app_validators.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/intent/checkout_intent.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiftWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const GiftWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneController,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Switch(
                    value: state
                        .isGift, // context.watch<CheckoutCubit>().state.isGift,
                    activeThumbColor: theme.colorScheme.secondary,
                    activeTrackColor: theme.colorScheme.primary,
                    inactiveThumbColor: theme.colorScheme.primary,
                    trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return theme
                            .colorScheme
                            .secondary; // Outline color when the switch is ON
                      }
                      return theme
                          .colorScheme
                          .primary; // Outline color when the switch is OFF
                    }),
                    onChanged: (value) {
                      context.read<CheckoutCubit>().handleCheckoutIntent(
                        SelectIsItGiftIntent(isGift: value),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Text(
                    appLocalizations!.itIsGift,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),

              if (state.isGift) ...[
                const SizedBox(height: 16),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: appLocalizations.userName,
                          hintText: appLocalizations.enterTheName,
                        ),
                        validator: (value) => AppValidators.validateName(
                          context,
                          value,
                          AppStrings.userName,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          labelText: appLocalizations.phone,
                          hintText: appLocalizations.enterPhoneNumber,
                        ),
                        validator: (value) =>
                            AppValidators.validatePhoneNumber(context, value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ],
          ),
        );
      },
    );
  }
}
