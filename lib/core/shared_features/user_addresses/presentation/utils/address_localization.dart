import 'package:flower_app/core/shared_features/user_addresses/presentation/utils/address_message_keys.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

String localizeAddressMessage(BuildContext context, String? message) {
  if (message == null || message.isEmpty) return '';

  final loc = AppLocalizations.of(context)!;

  return switch (message) {
    AddressMessageKeys.recipientNameRequired => loc.recipientNameRequired,
    AddressMessageKeys.nameLength => loc.nameLength,
    AddressMessageKeys.phoneRequired => loc.phoneRequired,
    AddressMessageKeys.phoneInvalid => loc.phoneInvalid,
    AddressMessageKeys.governorateRequired => loc.governorateRequired,
    AddressMessageKeys.cityRequired => loc.cityRequired,
    AddressMessageKeys.streetAddressRequired => loc.streetAddressRequired,
    AddressMessageKeys.streetAddressMinLength => loc.streetAddressMinLength,
    AddressMessageKeys.selectLocationOnMap => loc.selectLocationOnMap,
    AddressMessageKeys.addressSavedSuccessfully => loc.addressSavedSuccessfully,
    AddressMessageKeys.addressUpdatedSuccessfully =>
      loc.addressUpdatedSuccessfully,
    AddressMessageKeys.addressNotFound => loc.addressNotFound,
    AddressMessageKeys.failedLoadLocations => loc.failedLoadLocations,
    AddressMessageKeys.locationServicesDisabled => loc.locationServicesDisabled,
    AddressMessageKeys.locationPermissionRequired =>
      loc.locationPermissionRequired,
    AddressMessageKeys.locationPermissionDeniedForever =>
      loc.locationPermissionDeniedForever,
    AddressMessageKeys.failedGetCurrentLocation => loc.failedGetCurrentLocation,
    _ => message,
  };
}
