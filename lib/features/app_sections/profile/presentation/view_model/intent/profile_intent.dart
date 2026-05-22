sealed class ProfileIntent {}

class LoadUserProfileIntent extends ProfileIntent {}

class ChangeLanguageIntent extends ProfileIntent {
  final String languageCode;

  ChangeLanguageIntent(this.languageCode);
}

class LogoutIntent extends ProfileIntent {}
