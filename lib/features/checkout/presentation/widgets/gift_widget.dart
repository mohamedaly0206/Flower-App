import 'package:flower_app/core/utilities/app_validators.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class GiftWidget extends StatelessWidget {
  GiftWidget({super.key});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Switch(
                value: true,
                // value: state.isGift,
                activeThumbColor: theme.colorScheme.secondary,
                activeTrackColor: theme.colorScheme.primary,
                onChanged: (value) {
                  // context.read<CheckoutCubit>().toggleGift(value);
                },
              ),
              const SizedBox(width: 8),
              Text(
                appLocalizations!.itIsGift,
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),

          // if (state.isGift) ...[
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
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
                  controller: _phoneNumberController,
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
        ],
      ),
    );
  }
}
