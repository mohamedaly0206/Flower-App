import 'package:flower_app/features/auth/login/api/data_sources/login_remote_data_source_impl.dart';
import 'package:flower_app/features/auth/login/api/login_api_client/login_api_client.dart';
import 'package:flower_app/features/auth/login/data/models/login_request.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLoginApiClient implements LoginApiClient {
  LoginRequest? receivedBody;
  late LoginResponse response;

  @override
  Future<LoginResponse> login({required LoginRequest body}) async {
    receivedBody = body;
    return response;
  }
}

void main() {
  group('LoginRemoteDataSourceImpl', () {
    test('sends email and password in the request body', () async {
      final apiClient = _FakeLoginApiClient()
        ..response = LoginResponse(message: 'success', token: 'token');
      final dataSource = LoginRemoteDataSourceImpl(apiClient);

      final result = await dataSource.login('user@mail.com', 'password123');

      expect(result, same(apiClient.response));
      expect(apiClient.receivedBody?.toJson(), {
        'email': 'user@mail.com',
        'password': 'password123',
      });
    });
  });
}
