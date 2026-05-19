abstract interface class LoginLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> clearToken();

  Future<void> saveRememberMe(bool rememberMe);

  Future<bool> getRememberMe();

  Future<void> cacheUserData(Map<String, dynamic> userJson);
}
