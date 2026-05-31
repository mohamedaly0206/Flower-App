import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Flower App'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @noToken.
  ///
  /// In en, this message translates to:
  /// **'noToken'**
  String get noToken;

  /// No description provided for @authorization.
  ///
  /// In en, this message translates to:
  /// **'Authorization'**
  String get authorization;

  /// No description provided for @bearer.
  ///
  /// In en, this message translates to:
  /// **'Bearer'**
  String get bearer;

  /// No description provided for @loginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Login Successfully'**
  String get loginSuccessfully;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailKey.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get emailKey;

  /// No description provided for @token.
  ///
  /// In en, this message translates to:
  /// **'token'**
  String get token;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterTheName.
  ///
  /// In en, this message translates to:
  /// **'Enter the name'**
  String get enterTheName;

  /// No description provided for @enterThePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter the phone Number'**
  String get enterThePhoneNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordKey.
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get passwordKey;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @doNotHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get doNotHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @enterYourUserName.
  ///
  /// In en, this message translates to:
  /// **'Enter your user name'**
  String get enterYourUserName;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @hintFirstNameText.
  ///
  /// In en, this message translates to:
  /// **'Enter first name'**
  String get hintFirstNameText;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @enterYourLastName.
  ///
  /// In en, this message translates to:
  /// **'Enter last name'**
  String get enterYourLastName;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @creatingAnAccountYouAgreeToOur.
  ///
  /// In en, this message translates to:
  /// **'Creating an account, you agree to our'**
  String get creatingAnAccountYouAgreeToOur;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms&Conditions'**
  String get termsAndConditions;

  /// No description provided for @signUpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Sign up successfully'**
  String get signUpSuccessMessage;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email associated to\nyour account'**
  String get enterEmail;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get didNotReceiveCode;

  /// No description provided for @emailVerification.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get emailVerification;

  /// No description provided for @invalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get invalidCode;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter your code that send to your \n email address'**
  String get enterCode;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code? '**
  String get verifyButton;

  /// No description provided for @resendButton.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resendButton;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @resetPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain \n 6 characters with upper case letter and one \n number at least '**
  String get resetPasswordHint;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @flowery.
  ///
  /// In en, this message translates to:
  /// **'Flowery'**
  String get flowery;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @bestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best seller'**
  String get bestSeller;

  /// No description provided for @occasion.
  ///
  /// In en, this message translates to:
  /// **'Occasion'**
  String get occasion;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @bloomWithBestSellers.
  ///
  /// In en, this message translates to:
  /// **'Bloom with our exquisite best sellers'**
  String get bloomWithBestSellers;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @pricesIncludedTax.
  ///
  /// In en, this message translates to:
  /// **'All prices include tax'**
  String get pricesIncludedTax;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @dummyAddress.
  ///
  /// In en, this message translates to:
  /// **'2XVP+XC - Sheikh Zayed'**
  String get dummyAddress;

  /// No description provided for @deliverTo.
  ///
  /// In en, this message translates to:
  /// **'Deliver to '**
  String get deliverTo;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In stock'**
  String get inStock;

  /// No description provided for @outOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of stock'**
  String get outOfStock;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No Products Found'**
  String get noProductsFound;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @deliveryTime.
  ///
  /// In en, this message translates to:
  /// **'Delivery time'**
  String get deliveryTime;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery address'**
  String get deliveryAddress;

  /// No description provided for @addNew.
  ///
  /// In en, this message translates to:
  /// **'Add new'**
  String get addNew;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cashOnDelivery;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get creditCard;

  /// No description provided for @itIsGift.
  ///
  /// In en, this message translates to:
  /// **'It is a gift'**
  String get itIsGift;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subTotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @emptyCart.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty 🌸\nStart shopping and find something you’ll love!'**
  String get emptyCart;

  /// No description provided for @successAddToCart.
  ///
  /// In en, this message translates to:
  /// **'Item added to cart'**
  String get successAddToCart;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter the address'**
  String get enterAddress;

  /// No description provided for @enterRecipientName.
  ///
  /// In en, this message translates to:
  /// **'Enter the recipient name'**
  String get enterRecipientName;

  /// No description provided for @recipientName.
  ///
  /// In en, this message translates to:
  /// **'Recipient name'**
  String get recipientName;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @savedAddress.
  ///
  /// In en, this message translates to:
  /// **'Saved address'**
  String get savedAddress;

  /// No description provided for @saveAddress.
  ///
  /// In en, this message translates to:
  /// **'Save address'**
  String get saveAddress;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add new address'**
  String get addNewAddress;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @searchForAnyProduct.
  ///
  /// In en, this message translates to:
  /// **'Search For Any Product You Want'**
  String get searchForAnyProduct;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @trackOrder.
  ///
  /// In en, this message translates to:
  /// **'Track order'**
  String get trackOrder;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your order placed successfully!'**
  String get orderPlacedSuccessfully;

  /// No description provided for @estimatedArrival.
  ///
  /// In en, this message translates to:
  /// **'Estimated arrival'**
  String get estimatedArrival;

  /// No description provided for @showMap.
  ///
  /// In en, this message translates to:
  /// **'Show map'**
  String get showMap;

  /// No description provided for @orderDelivered.
  ///
  /// In en, this message translates to:
  /// **'Order Delivered'**
  String get orderDelivered;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order details'**
  String get orderDetails;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My orders'**
  String get myOrders;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm logout!!'**
  String get confirmLogout;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @storeCacheExceptionMessage.
  ///
  /// In en, this message translates to:
  /// **'failed to store data locally, please try again later'**
  String get storeCacheExceptionMessage;

  /// No description provided for @getCacheExceptionMessage.
  ///
  /// In en, this message translates to:
  /// **'failed to get data locally, please try again later'**
  String get getCacheExceptionMessage;

  /// No description provided for @cacheStorageError.
  ///
  /// In en, this message translates to:
  /// **'Storage Error'**
  String get cacheStorageError;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again later'**
  String get errorMessage;

  /// No description provided for @serverConnTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout with API server'**
  String get serverConnTimeout;

  /// No description provided for @serverSendTimeout.
  ///
  /// In en, this message translates to:
  /// **'Send timeout with API server'**
  String get serverSendTimeout;

  /// No description provided for @serverRecTimeout.
  ///
  /// In en, this message translates to:
  /// **'Receive timeout with API server'**
  String get serverRecTimeout;

  /// No description provided for @serverCertError.
  ///
  /// In en, this message translates to:
  /// **'Bad certificate with API server'**
  String get serverCertError;

  /// No description provided for @serverCancel.
  ///
  /// In en, this message translates to:
  /// **'Request to API server was cancelled'**
  String get serverCancel;

  /// No description provided for @serverConnError.
  ///
  /// In en, this message translates to:
  /// **'There is Connection Error'**
  String get serverConnError;

  /// No description provided for @serverNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get serverNoInternet;

  /// No description provided for @serverInvalidCreds.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get serverInvalidCreds;

  /// No description provided for @serverNotFound.
  ///
  /// In en, this message translates to:
  /// **'Opps there was an error, please try again'**
  String get serverNotFound;

  /// No description provided for @serverInternalError.
  ///
  /// In en, this message translates to:
  /// **'Internal server error, please try again later'**
  String get serverInternalError;

  /// No description provided for @serverDefaultError.
  ///
  /// In en, this message translates to:
  /// **'Opps there was an error, please try again'**
  String get serverDefaultError;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailNotValid.
  ///
  /// In en, this message translates to:
  /// **'This Email is not valid'**
  String get emailNotValid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordLength;

  /// No description provided for @passwordInvalid.
  ///
  /// In en, this message translates to:
  /// **'password must contain upper and lowercase, number and symbol'**
  String get passwordInvalid;

  /// No description provided for @passwordNotMatched.
  ///
  /// In en, this message translates to:
  /// **'Password not matched'**
  String get passwordNotMatched;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @nameLength.
  ///
  /// In en, this message translates to:
  /// **'length must be at least 3 characters long'**
  String get nameLength;

  /// No description provided for @nameOnlyLetters.
  ///
  /// In en, this message translates to:
  /// **'must contain letters only'**
  String get nameOnlyLetters;

  /// No description provided for @nameNoSpaces.
  ///
  /// In en, this message translates to:
  /// **'cannot contain spaces'**
  String get nameNoSpaces;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid Egyptian phone number'**
  String get phoneInvalid;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
