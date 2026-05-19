import '../../l10n/app_localizations.dart';
import '../router/app_router.dart';

abstract class AppValidators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.emailRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.emailNotValid;
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.passwordRequired;
    }

    if (password.length < 8) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.passwordLength;
    }

    if (!RegExp(
      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$",
    ).hasMatch(password)) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.passwordInvalid;
    }

    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (password != confirmPassword ||
        confirmPassword == null ||
        confirmPassword.isEmpty) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.passwordNotMatched;
    }

    return null;
  }

  static String? validateEmptyTextFormField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.fieldRequired;
    }
    return null;
  }

  static String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 3) {
      return '$fieldName ${AppLocalizations.of(navigatorKey.currentContext!)!.nameLength}';
    }

    final nameRegex = RegExp(r'^[a-zA-Z]+$');

    if (!nameRegex.hasMatch(trimmedValue)) {
      return '$fieldName ${AppLocalizations.of(navigatorKey.currentContext!)!.nameOnlyLetters}';
    }
    if (value.contains(' ')) {
      return '$fieldName ${AppLocalizations.of(navigatorKey.currentContext!)!.nameNoSpaces}';
    }

    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.phoneRequired;
    }

    if (!RegExp(r'^\+20(10|11|12|15)[0-9]{8}$').hasMatch(phoneNumber)) {
      return AppLocalizations.of(navigatorKey.currentContext!)!.phoneInvalid;
    }

    return null;
  }
}
