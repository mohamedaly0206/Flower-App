import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/exceptions.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/auth/login/data/data_sources/login_local_data_source.dart';
import 'package:flower_app/features/auth/login/data/data_sources/login_remote_data_source.dart';
import 'package:flower_app/features/auth/login/data/models/login_response/login_response.dart';
import 'package:flower_app/features/auth/login/domain/repo/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  final LoginLocalDataSource _localDataSource;

  LoginRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<BaseResponse<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(email, password);
      final token = response.token;
      if (token == null || token.isEmpty) {
        throw CacheException(errorMessage: AppStrings.cacheStorageError);
      }
      await _localDataSource.saveToken(token);
      return SuccessBaseResponse(data: response);
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: error is CacheException
            ? CacheFailure(error).errorMessage
            : ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }
}
