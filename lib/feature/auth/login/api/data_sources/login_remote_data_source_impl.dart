import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/feature/auth/login/api/login_api_client/login_api_client.dart';
import 'package:flower_app/feature/auth/login/data/data_sources/login_remote_data_source.dart';
import 'package:flower_app/feature/auth/login/data/models/login_response/login_response.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final LoginApiClient _loginApiClient;

  LoginRemoteDataSourceImpl(this._loginApiClient);

  @override
  Future<LoginResponse> login(String email, String password) {
    return _loginApiClient.login(
      body: {
        ApiParam.email: email,
        ApiParam.password: password,
      },
    );
  }
}
