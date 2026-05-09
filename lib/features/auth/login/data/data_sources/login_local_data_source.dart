abstract interface class LoginLocalDataSource {
  Future<void> saveToken(String token);
}
