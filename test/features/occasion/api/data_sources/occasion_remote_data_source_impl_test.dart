import 'package:flower_app/features/occasion/api/api_client/occasion_api_client.dart';
import 'package:flower_app/features/occasion/api/datasources/occasion_remote_data_source_impl.dart';
import 'package:flower_app/features/occasion/data/models/occasions_response.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Fake API client — replaces the real Retrofit client in tests.
// ---------------------------------------------------------------------------
class _FakeOccasionApiClient implements OccasionApiClient {
  OccasionsResponse? response;
  Object? error;

  @override
  Future<OccasionsResponse> getOccasions() async {
    final err = error;
    if (err != null) throw err;
    return response!;
  }
}

void main() {
  group('OccasionRemoteDataSourceImpl', () {
    late _FakeOccasionApiClient apiClient;
    late OccasionRemoteDataSourceImpl dataSource;

    setUp(() {
      apiClient = _FakeOccasionApiClient();
      dataSource = OccasionRemoteDataSourceImpl(apiClient);
    });

    // -----------------------------------------------------------------------
    // Success path
    // Validates that the data source simply forwards the API client's response
    // to the caller without any modification.
    // -----------------------------------------------------------------------
    test('returns the response from the API client on success', () async {
      // Arrange
      final expectedResponse = OccasionsResponse(
        message: 'success',
        occasions: [],
      );
      apiClient.response = expectedResponse;

      // Act
      final result = await dataSource.getOccasions();

      // Assert
      expect(result, same(expectedResponse));
    });

    // -----------------------------------------------------------------------
    // Failure path
    // Validates that exceptions thrown by the API client bubble up unchanged
    // so the repository layer can handle them.
    // -----------------------------------------------------------------------
    test('propagates exceptions thrown by the API client', () async {
      // Arrange
      apiClient.error = Exception('network failure');

      // Act & Assert
      expect(dataSource.getOccasions(), throwsException);
    });
  });
}
