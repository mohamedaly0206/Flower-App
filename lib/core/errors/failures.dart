import 'package:dio/dio.dart';
import '../values/app_strings.dart';
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
      return ServerFailure(AppStrings.errorMessage);
    }
  }

  factory ServerFailure.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(AppStrings.serverConnTimeout);
      case DioExceptionType.sendTimeout:
        return ServerFailure(AppStrings.serverSendTimeout);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(AppStrings.serverRecTimeout);
      case DioExceptionType.badCertificate:
        return ServerFailure(AppStrings.serverCertError);
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          exception.response?.statusCode,
          exception.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(AppStrings.serverCancel);
      case DioExceptionType.connectionError:
        return ServerFailure(AppStrings.serverConnError);
      case DioExceptionType.unknown:
        return ServerFailure(AppStrings.serverNoInternet);
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == null) {
      return ServerFailure(AppStrings.serverDefaultError);
    }

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        final String errorMessageRes =
            response?['message'] ?? AppStrings.errorMessage;
        return ServerFailure(errorMessageRes);

      case 404:
        return ServerFailure(AppStrings.serverNotFound);

      case 409:
        final message =
            response?['message']?.toString() ?? AppStrings.errorMessage;
        return ServerFailure(message);

      case 500:
        return ServerFailure(AppStrings.serverInternalError);

      default:
        return ServerFailure(AppStrings.serverDefaultError);
    }
  }
}

class CacheFailure extends Failure {
  CacheFailure(Object e)
    : super(
        e is CacheException ? e.errorMessage : AppStrings.cacheStorageError,
      );
}
