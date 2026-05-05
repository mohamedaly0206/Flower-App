import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/values/api_endpoints.dart';

@module
abstract class DioModule {
  @singleton
  Dio get dio => Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ),
  );
}
