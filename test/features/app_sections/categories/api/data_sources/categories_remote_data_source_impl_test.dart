import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/categories/api/categories_api_client/categories_api_client.dart';
import 'package:flower_app/features/app_sections/categories/api/data_sources/categories_remote_data_source_impl.dart';
import 'package:flower_app/features/app_sections/categories/data/models/category_dto.dart';
import 'package:flower_app/features/app_sections/categories/data/models/metadata_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Ensure you run 'flutter pub run build_runner build' to generate this file
@GenerateMocks([CategoriesApiClient])
import 'categories_remote_data_source_impl_test.mocks.dart';

void main() {
  late CategoriesRemoteDataSourceImpl dataSource;
  late MockCategoriesApiClient mockApiClient;

  setUpAll(() {
    // Providing a dummy for Mockito to use when returning types in null-safe environments
    provideDummy<BaseResponse<CategoryDto>>(
      SuccessBaseResponse<CategoryDto>(
        data: CategoryDto(metadata: MetadataDto(), message: '', categories: []),
      ),
    );
  });

  setUp(() {
    mockApiClient = MockCategoriesApiClient();
    dataSource = CategoriesRemoteDataSourceImpl(
      categoriesApiClient: mockApiClient,
    );
  });

  group('getCategories - Success State', () {
    test(
      'should return SuccessBaseResponse when the API call is successful',
      () async {
        // Arrange
        final tCategoryDto = CategoryDto(
          message: 'Success',
          categories: [],
          metadata: MetadataDto(currentPage: 1),
        );
        final tResponse = SuccessBaseResponse<CategoryDto>(data: tCategoryDto);

        when(
          mockApiClient.getCategories(),
        ).thenAnswer((_) async => tResponse.data);

        // Act
        final result = await dataSource.getCategories();

        // Assert
        expect(result, isA<SuccessBaseResponse<CategoryDto>>());
        expect((result as SuccessBaseResponse).data, equals(tCategoryDto));
        verify(mockApiClient.getCategories()).called(1);
      },
    );
  });

  group('getCategories - Failure States', () {
    test(
      'should return ErrorBaseResponse when the API client throws a generic Exception',
      () async {
        // Arrange
        when(
          mockApiClient.getCategories(),
        ).thenThrow(Exception('Unexpected Error'));

        // Act
        final result = await dataSource.getCategories();

        // Assert
        expect(result, isA<ErrorBaseResponse<CategoryDto>>());
        verify(mockApiClient.getCategories()).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse with the correct error message',
      () async {
        // Arrange
        final tException = Exception("Network timeout");
        when(mockApiClient.getCategories()).thenThrow(tException);

        // Act
        final result = await dataSource.getCategories();

        // Assert
        expect(result, isA<ErrorBaseResponse<CategoryDto>>());
        final errorResult = result as ErrorBaseResponse<CategoryDto>;

        // FIXED: Removed expect(..., isNull) because the message is actually present.
        expect(errorResult.errorMessage, isNotNull);
        expect(errorResult.errorMessage, isNotEmpty);
        expect(
          errorResult.errorMessage,
          equals('Something went wrong, please try again later'),
        );
      },
    );

    test(
      'should NOT throw an unhandled exception when API fails with ArgumentError',
      () async {
        // Arrange
        when(
          mockApiClient.getCategories(),
        ).thenThrow(ArgumentError('Invalid argument'));

        // Act & Assert
        // We expect the data source to catch the error and return an ErrorBaseResponse
        // instead of letting the app crash.
        final result = await dataSource.getCategories();
        expect(result, isA<ErrorBaseResponse<CategoryDto>>());
      },
    );
  });
}
