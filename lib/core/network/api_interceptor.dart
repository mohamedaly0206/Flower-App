import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../config/security_storage/security_storage.dart';
import '../errors/exceptions.dart';
import '../values/app_strings.dart';

@injectable
class ApiInterceptor extends Interceptor {
  final SecurityStorage _securityStorage;

  ApiInterceptor(this._securityStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const String testToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNmE3MjgyODMzYmUxMjY2ZGVjN2M0NWM1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3ODU4OTEyOTZ9.nMJNB-megBE2Y9SukbJeoexApa4qGnczbgtMC9JvU2c";
    if (options.extra[AppStrings.noToken] == true) {
      return handler.next(options);
    }

    try {
      final String token = await _securityStorage.getSecuredString(
        AppStrings.token,
      );

      if (token.isNotEmpty) {
        options.headers[AppStrings.authorization] =
            '${AppStrings.bearer} $testToken';
      }

      return handler.next(options);
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: CacheException(errorMessage: 'cache_read_error'),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }
}
