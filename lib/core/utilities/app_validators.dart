import '../values/app_strings.dart';

abstract class AppValidators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.emailRequired;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(email)) {
      return AppStrings.emailNotValid;
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.passwordRequired;
    }

    if (password.length < 8) {
      return AppStrings.passwordLength;
    }

    if (!RegExp(
      r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$",
    ).hasMatch(password)) {
      return AppStrings.passwordInvalid;
    }

    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (password != confirmPassword ||
        confirmPassword == null ||
        confirmPassword.isEmpty) {
      return AppStrings.passwordNotMatched;
    }

    return null;
  }

  static String? validateEmptyTextFormField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired;
    }
    return null;
  }

  static String? validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 3) {
      return '$fieldName ${AppStrings.nameLength}';
    }

    final nameRegex = RegExp(r'^[a-zA-Z]+$');

    if (!nameRegex.hasMatch(trimmedValue)) {
      return '$fieldName ${AppStrings.nameOnlyLetters}';
    }
    if (value.contains(' ')) {
      return '$fieldName ${AppStrings.nameNoSpaces}';
    }

    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return AppStrings.phoneRequired;
    }

    if (!RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber)) {
      return AppStrings.phoneInvalid;
    }

    return null;
  }
}
