import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

abstract class AppValidators {
  static String? validateEmail(BuildContext context, String? email) {
    final loc = AppLocalizations.of(context)!;

    if (email == null || email.isEmpty) {
      return loc.emailRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return loc.emailNotValid;
    }

    return null;
  }

  static String? validatePassword(BuildContext context, String? password) {
    final loc = AppLocalizations.of(context)!;

    if (password == null || password.isEmpty) {
      return loc.passwordRequired;
    }

    if (password.length < 8) {
      return loc.passwordLength;
    }

    if (!RegExp(
      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$",
    ).hasMatch(password)) {
      return loc.passwordInvalid;
    }

    return null;
  }

  static String? confirmPassword(
    BuildContext context,
    String? password,
    String? confirmPassword,
  ) {
    if (password != confirmPassword ||
        confirmPassword == null ||
        confirmPassword.isEmpty) {
      return AppLocalizations.of(context)!.passwordNotMatched;
    }

    return null;
  }

  static String? validateEmptyTextFormField(
    BuildContext context,
    String? value,
  ) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired;
    }
    return null;
  }

  static String? validateName(
    BuildContext context,
    String? value,
    String fieldName,
  ) {
    final loc = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 3) {
      return '$fieldName ${loc.nameLength}';
    }

    final nameRegex = RegExp(r'^[a-zA-Z]+$');

    if (!nameRegex.hasMatch(trimmedValue)) {
      return '$fieldName ${loc.nameOnlyLetters}';
    }
    if (value.contains(' ')) {
      return '$fieldName ${loc.nameNoSpaces}';
    }

    return null;
  }

  static String? validatePhoneNumber(
    BuildContext context,
    String? phoneNumber,
  ) {
    final loc = AppLocalizations.of(context)!;

    if (phoneNumber == null || phoneNumber.isEmpty) {
      return loc.phoneRequired;
    }

    if (!RegExp(r'^\+20(10|11|12|15)[0-9]{8}$').hasMatch(phoneNumber)) {
      return loc.phoneInvalid;
    }

    return null;
  }
}
