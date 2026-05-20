abstract class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://flower.elevateegy.com/api/v1';

  //auth
  static const String login = '$baseUrl/auth/signin';
  static const String signUp = '$baseUrl/auth/signup';
  static const String changePassword = '$baseUrl/auth/change-password';
  static const String uploadProfilePhoto = '$baseUrl/auth/upload-photo';
  static const String getLoggedUserData = '$baseUrl/auth/profile-data';
  static const String logout = '$baseUrl/auth/logout';
  static const String forgetPassword = '$baseUrl/auth/forgotPassword';
  static const String verifyResetCode = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
  static const String deleteAccount = '$baseUrl/auth/deleteMe';
  static const String editProfile = '$baseUrl/auth/editProfile';
  static const String changeUserRole = '$baseUrl/auth/update-role/';

  //products
  static const String products = '$baseUrl/products';
  //static const String countByCategory = 'https://flower.elevateegy.com/products/count-by-category';
  static const String categories = '$baseUrl/categories';
  static const String occasions = '$baseUrl/occasions';
  static const String cart = '$baseUrl/cart';
  static const String wishlist = '$baseUrl/wishlist';
  static const String coupons = '$baseUrl/coupons';
  static const String applyCoupon = '$baseUrl/coupons/apply';
  static const String validateCoupon = '$baseUrl/coupons/validate';
  static const String uploads = 'https://flower.elevateegy.com/uploads';
  //orders
  static const String orders = '$baseUrl/orders';
  static const String addresses = '$baseUrl/addresses';
  static const String subscribe = '$baseUrl/subscriptions/subscribe';
  static const String unsubscribe = '$baseUrl/subscriptions/unsubscribe';
  static const String subscriptions = '$baseUrl/subscriptions';
  static const String subscriptionsCount = '$baseUrl/subscriptions/counts';

  //home
  static const String home = '$baseUrl/home';
  static const String bestSeller = '$baseUrl/best-seller';

  //driver
  static const String driversApply = '$baseUrl/drivers/apply';
  static const String driversSignIn = '$baseUrl/drivers/signin';
  static const String driversChangePassword =
      '$baseUrl/drivers/change-password';
  static const String driversUploadPhoto = '$baseUrl/drivers/upload-photo';
  static const String driversProfileData = '$baseUrl/drivers/profile-data';
  static const String driversLogout = '$baseUrl/drivers/logout';
  static const String driversForgotPassword = '$baseUrl/drivers/forgotPassword';
  static const String driversVerifyResetCode =
      '$baseUrl/drivers/verifyResetCode';
  static const String driversVerifyResetPassword =
      '$baseUrl/drivers/resetPassword';
  static const String driversDeleteAcc = '$baseUrl/drivers/deleteMe';
  static const String driversEditProfile = '$baseUrl/drivers/editProfile';
  static const String vehicle = '$baseUrl/vehicles';
  static const String orderState = '$baseUrl/orders/complete';
}
