import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(BaseOptions(
    validateStatus: (status) => true, // don't throw on 4xx/5xx
  ));

  print('--- Testing PUT ---');
  final resPut = await dio.put('https://flower.elevateegy.com/api/v1/auth/editProfile', data: {});
  print('PUT Status: \${resPut.statusCode}');
  print('PUT Response: \${resPut.data}');

  print('\n--- Testing PATCH ---');
  final resPatch = await dio.patch('https://flower.elevateegy.com/api/v1/auth/editProfile', data: {});
  print('PATCH Status: \${resPatch.statusCode}');
  print('PATCH Response: \${resPatch.data}');

  print('\n--- Testing POST ---');
  final resPost = await dio.post('https://flower.elevateegy.com/api/v1/auth/editProfile', data: {});
  print('POST Status: \${resPost.statusCode}');
  print('POST Response: \${resPost.data}');
}
