import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../config/security_storage/security_storage.dart';
import '../../l10n/app_localizations.dart';
import '../errors/exceptions.dart';
import '../router/app_router.dart';
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
          error: CacheException(
            errorMessage: AppLocalizations.of(
              navigatorKey.currentContext!,
            )!.getCacheExceptionMessage,
          ),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }
}
