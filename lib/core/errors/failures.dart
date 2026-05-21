import 'package:dio/dio.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import '../router/app_router.dart';
import 'exceptions.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  static ServerFailure failureHandler(Object e) {
    if (e is DioException) {
      return ServerFailure.fromDioException(e);
    } else {
      return ServerFailure(
        AppLocalizations.of(navigatorKey.currentContext!)!.errorMessage,
      );
    }
  }

  factory ServerFailure.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverConnTimeout,
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverSendTimeout,
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverRecTimeout,
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverCertError,
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          exception.response?.statusCode,
          exception.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverCancel,
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverConnError,
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverNoInternet,
        );
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == null) {
      return ServerFailure(
        AppLocalizations.of(navigatorKey.currentContext!)!.serverDefaultError,
      );
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        final String errorMessageRes =
            response?['message'] ??
            AppLocalizations.of(navigatorKey.currentContext!)!.errorMessage;
        return ServerFailure(errorMessageRes);

      case 404:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverNotFound,
        );

      case 409:
        final message =
            response?['message']?.toString() ??
            AppLocalizations.of(navigatorKey.currentContext!)!.errorMessage;
        return ServerFailure(message);

      case 500:
        return ServerFailure(
          AppLocalizations.of(
            navigatorKey.currentContext!,
          )!.serverInternalError,
        );

      default:
        return ServerFailure(
          AppLocalizations.of(navigatorKey.currentContext!)!.serverDefaultError,
        );
    }
  }
}

class CacheFailure extends Failure {
  CacheFailure(Object e)
    : super(
        e is CacheException
            ? e.errorMessage
            : AppLocalizations.of(
                navigatorKey.currentContext!,
              )!.cacheStorageError,
      );
}
