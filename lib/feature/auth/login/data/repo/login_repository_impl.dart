import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/security_storage/security_storage.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/core/values/api_param.dart';
import 'package:flower_app/feature/auth/login/data/data_sources/login_remote_data_source.dart';
import 'package:flower_app/feature/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/feature/auth/login/domain/repo/login_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  final SecurityStorage _securityStorage;

  LoginRepositoryImpl(this._remoteDataSource, this._securityStorage);

  @override
  Future<BaseResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(email, password);
      final token = response.token;
      _securityStorage.setSecuredString(ApiParam.token, token!);
      return SuccessBaseResponse(data: response);
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }
}
