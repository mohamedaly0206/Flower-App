import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/cubit/user_addresses_cubit.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flower_app/core/shared_features/user_addresses/presentation/widgets/address_map_widget.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressForm extends StatelessWidget {
  final TextEditingController streetController;
  final TextEditingController phoneController;
  final TextEditingController usernameController;

  const AddressForm({
    super.key,
    required this.streetController,
    required this.phoneController,
    required this.usernameController,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<UserAddressesCubit, UserAddressesState>(
      builder: (context, state) {
        final isArabic = Localizations.localeOf(context).languageCode == 'ar';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AddressMapWidget(),
            const SizedBox(height: 24),
            _AddressTextField(
              id: 'street',
              label: loc.address,
              hint: loc.enterAddress,
              controller: streetController,
              onChanged: (value) => context
                  .read<UserAddressesCubit>()
                  .handleIntent(UpdateStreetIntent(value)),
            ),
            const SizedBox(height: 24),
            _AddressTextField(
              id: 'phone',
              label: loc.phone,
              hint: loc.enterThePhoneNumber,
              controller: phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (value) => context
                  .read<UserAddressesCubit>()
                  .handleIntent(UpdatePhoneIntent(value)),
            ),
            const SizedBox(height: 24),
            _AddressTextField(
              id: 'username',
              label: loc.recipientName,
              hint: loc.enterRecipientName,
              controller: usernameController,
              onChanged: (value) => context
                  .read<UserAddressesCubit>()
                  .handleIntent(UpdateUsernameIntent(value)),
            ),
            const SizedBox(height: 24),
            _LocationDropdown(
              label: loc.governorate,
              hint: loc.selectGovernorate,
              value: state.governorateId.isEmpty ? null : state.governorateId,
              items: state.governorates
                  .map(
                    (governorate) => DropdownMenuItem<String>(
                      value: governorate.id,
                      child: Text(
                        isArabic ? governorate.nameAr : governorate.nameEn,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                final governorate = state.governorates.firstWhere(
                  (g) => g.id == value,
                );
                context.read<UserAddressesCubit>().handleIntent(
                  UpdateGovernorateIntent(
                    governorateId: governorate.id,
                    governorateName: isArabic
                        ? governorate.nameAr
                        : governorate.nameEn,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            _LocationDropdown(
              label: loc.city,
              hint: loc.selectCity,
              value: state.cityId.isEmpty ? null : state.cityId,
              enabled: state.governorateId.isNotEmpty,
              items: state.filteredCities
                  .map(
                    (city) => DropdownMenuItem<String>(
                      value: city.id,
                      child: Text(isArabic ? city.nameAr : city.nameEn),
                    ),
                  )
                  .toList(),
              onChanged: state.governorateId.isEmpty
                  ? null
                  : (value) {
                      if (value == null) return;
                      final city = state.filteredCities.firstWhere(
                        (c) => c.id == value,
                      );
                      context.read<UserAddressesCubit>().handleIntent(
                        UpdateCityIntent(cityId: city.id, city: city.nameEn),
                      );
                    },
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: state.status == UserAddressesStatus.saving
                    ? null
                    : () {
                        final cubit = context.read<UserAddressesCubit>();
                        if (state.isEditMode) {
                          cubit.handleIntent(const UpdateAddressIntent());
                        } else {
                          cubit.handleIntent(const AddAddressIntent());
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  disabledBackgroundColor: AppColors.placeHolderColor
                      .withValues(alpha: 0.6),
                  foregroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 0,
                  enableFeedback: false,
                ),
                child: Text(
                  loc.saveAddress,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LocationDropdown extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final bool enabled;
  final ValueChanged<String?>? onChanged;

  const _LocationDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: items.any((item) => item.value == value) ? value : null,
      items: items,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.placeHolderColor,
        ),
        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.placeHolderColor,
        ),
        filled: true,
        fillColor: AppColors.whiteColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.greyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
    );
  }
}

class _AddressTextField extends StatelessWidget {
  final String id;
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;

  const _AddressTextField({
    required this.id,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(id),
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 14, color: AppColors.blackColor),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.placeHolderColor,
        ),
        hintStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.placeHolderColor,
        ),
        filled: true,
        fillColor: AppColors.whiteColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.greyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
