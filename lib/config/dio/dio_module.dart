import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../core/network/api_interceptor.dart';
import '../../core/values/api_endpoints.dart';

@module
abstract class DioModule {
  @singleton
  Dio getDio(ApiInterceptor interceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(interceptor);

    // dio.interceptors.add(LogInterceptor(
    //   requestBody: true,
    //   responseBody: true,
    //   requestHeader: true,
    // ));

    return dio;
  }
}
