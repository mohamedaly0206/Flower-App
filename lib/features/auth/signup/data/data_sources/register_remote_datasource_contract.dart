import '../model/register_request.dart';
import '../model/register_response.dart';

abstract interface class RegisterRemoteDatasourceContract {
  Future<RegisterResponse> register(RegisterRequest request);
}
