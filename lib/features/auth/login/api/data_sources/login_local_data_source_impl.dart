import 'package:flower_app/config/security_storage/security_storage.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/features/auth/login/data/data_sources/login_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  final SecurityStorage _securityStorage;

  LoginLocalDataSourceImpl(this._securityStorage);

  @override
  Future<void> saveToken(String token) {
    return _securityStorage.setSecuredString(ApiParam.token, token);
  }

  @override
  Future<void> cacheUserData(Map<String, dynamic> userJson) async {
    await _securityStorage.setSecuredString(
      ApiParam.userEmail,
      userJson[ApiParam.userEmail] ?? '',
    );
    await _securityStorage.setSecuredString(
      ApiParam.userName,
      userJson[ApiParam.userName] ?? '',
    );
    await _securityStorage.setSecuredString(
      ApiParam.userPhoto,
      userJson[ApiParam.userPhoto] ?? '',
    );
  }

  @override
  Future<void> clearToken() {
    return _securityStorage.deleteSecuredString(ApiParam.token);
  }

  @override
  Future<bool> getRememberMe() {
    return _securityStorage.getSecuredBool(ApiParam.rememberMe);
  }

  @override
  Future<void> saveRememberMe(bool rememberMe) {
    return _securityStorage.setSecuredBool(ApiParam.rememberMe, rememberMe);
  }
}
