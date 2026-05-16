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
    //if there is no need for token will call the server directly
    if (options.extra[AppStrings.noToken] == true) {
      return handler.next(options);
    }

    try {
      final String token = await _securityStorage.getSecuredString(
        AppStrings.token,
      );

      if (token.isNotEmpty) {
        options.headers[AppStrings.authorization] =
            '${AppStrings.bearer} $token';
      }

      return handler.next(options);
    } catch (e) {
      // will not call the server
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const CacheException(
            errorMessage: AppStrings.getCacheExceptionMessage,
          ),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }
}
