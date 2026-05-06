import 'package:flower_app/feature/auth/login/data/models/login_response/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(String email, String password);
}