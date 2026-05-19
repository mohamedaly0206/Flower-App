import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/router/app_router.dart';
 
import 'package:flower_app/features/occasion/data/datasources/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/data/models/occasion_dto.dart';
import 'package:flower_app/features/occasion/data/models/occasions_response.dart';
import 'package:flower_app/features/occasion/data/repositories/occasion_repository_impl.dart';
import 'package:flower_app/features/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_app/features/occasion/domain/entities/occasions_response_entity.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Fake data source — injects controlled responses or errors.
// ---------------------------------------------------------------------------
class _FakeOccasionRemoteDataSource implements OccasionRemoteDataSource {
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
  group('OccasionRepositoryImpl', () {
    late _FakeOccasionRemoteDataSource remoteDataSource;
    late OccasionRepositoryImpl repository;

    setUp(() {
      remoteDataSource = _FakeOccasionRemoteDataSource();
      repository = OccasionRepositoryImpl(remoteDataSource);
    });

    // -----------------------------------------------------------------------
    // Success path — DTO → Entity mapping
    // Validates that the repository:
    //   1. Returns a SuccessBaseResponse wrapping an OccasionsResponseEntity.
    //   2. Correctly maps each OccasionDTO field to the corresponding entity.
    // -----------------------------------------------------------------------
    test(
      'returns SuccessBaseResponse with mapped entities on success',
      () async {
        // Arrange
        final dto = OccasionDTO(
          id: 'abc123',
          name: 'Birthday',
          slug: 'birthday',
          image: 'https://img.url/birthday.jpg',
          isSuperAdmin: false,
        );
        remoteDataSource.response = OccasionsResponse(
          message: 'Retrieved successfully',
          occasions: [dto],
        );

        // Act
        final result = await repository.getOccasions();

        // Assert — outer type
        expect(result, isA<SuccessBaseResponse<OccasionsResponseEntity>>());

        final success = result as SuccessBaseResponse<OccasionsResponseEntity>;

        // Assert — response-level fields
        expect(success.data.message, 'Retrieved successfully');
        expect(success.data.occasions, hasLength(1));

        // Assert — entity-level fields (DTO → Entity mapping)
        final entity = success.data.occasions!.first;
        expect(entity, isA<OccasionEntity>());
        expect(entity.id, 'abc123');
        expect(entity.name, 'Birthday');
        expect(entity.slug, 'birthday');
        expect(entity.image, 'https://img.url/birthday.jpg');
      },
    );

    // -----------------------------------------------------------------------
    // Success path — empty occasions list
    // Validates that a response with no occasions still maps correctly.
    // -----------------------------------------------------------------------
    test(
      'returns SuccessBaseResponse with empty list when occasions are absent',
      () async {
        // Arrange
        remoteDataSource.response = OccasionsResponse(
          message: 'No occasions',
          occasions: [],
        );

        // Act
        final result = await repository.getOccasions();

        // Assert
        expect(result, isA<SuccessBaseResponse<OccasionsResponseEntity>>());
        final success = result as SuccessBaseResponse<OccasionsResponseEntity>;
        expect(success.data.occasions, isEmpty);
      },
    );

    // -----------------------------------------------------------------------
    // Failure path — generic exception
    // Validates that when the data source throws a non-Dio exception, the
    // repository catches it and returns an ErrorBaseResponse with the generic
    // AppLocalizations.of(navigatorKey.currentContext!)!.errorMessage string.
    // -----------------------------------------------------------------------
    test(
      'returns ErrorBaseResponse with generic message on unknown exception',
      () async {
        // Arrange
        remoteDataSource.error = Exception('unexpected error');

        // Act
        final result = await repository.getOccasions();

        // Assert
        expect(result, isA<ErrorBaseResponse<OccasionsResponseEntity>>());
        final error = result as ErrorBaseResponse<OccasionsResponseEntity>;
        expect(error.errorMessage, AppLocalizations.of(navigatorKey.currentContext!)!.errorMessage);
      },
    );
  });
}
