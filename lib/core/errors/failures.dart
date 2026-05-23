import 'package:dio/dio.dart';
import '../../l10n/app_localizations.dart';
import '../router/app_router.dart';
import 'exceptions.dart';

/// A safe helper to retrieve localizations that won't crash during unit tests
/// or when the context isn't fully initialized yet.
String _getTranslation(
  String Function(AppLocalizations) selector, [
  String fallback = 'Something went wrong, please try again later',
]) {
  final context = navigatorKey.currentContext;
  if (context == null) return fallback;
  
  final loc = AppLocalizations.of(context);
  if (loc == null) return fallback;
  
  return selector(loc);
}

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
        _getTranslation((loc) => loc.errorMessage),
      );
    }
  }

  factory ServerFailure.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(_getTranslation((loc) => loc.serverConnTimeout));
      case DioExceptionType.sendTimeout:
        return ServerFailure(_getTranslation((loc) => loc.serverSendTimeout));
      case DioExceptionType.receiveTimeout:
        return ServerFailure(_getTranslation((loc) => loc.serverRecTimeout));
      case DioExceptionType.badCertificate:
        return ServerFailure(_getTranslation((loc) => loc.serverCertError));
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          exception.response?.statusCode,
          exception.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(_getTranslation((loc) => loc.serverCancel));
      case DioExceptionType.connectionError:
        return ServerFailure(_getTranslation((loc) => loc.serverConnError));
      case DioExceptionType.unknown:
        return ServerFailure(_getTranslation((loc) => loc.serverNoInternet));
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == null) {
      return ServerFailure(_getTranslation((loc) => loc.serverDefaultError));
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        final String errorMessageRes =
            response?['message'] ??
                response?['error'] ??
                _getTranslation((loc) => loc.errorMessage);
        return ServerFailure(errorMessageRes);

      case 404:
        return ServerFailure(_getTranslation((loc) => loc.serverNotFound));

      case 409:
        final message =
            response?['message']?.toString() ?? _getTranslation((loc) => loc.errorMessage);
        return ServerFailure(message);

      case 500:
        return ServerFailure(_getTranslation((loc) => loc.serverInternalError));

      default:
        return ServerFailure(_getTranslation((loc) => loc.serverDefaultError));
    }
  }
}

class CacheFailure extends Failure {
  CacheFailure(Object e)
      : super(
          e is CacheException
              ? e.errorMessage
              : _getTranslation((loc) => loc.cacheStorageError, 'Cache storage error'),
        );
}