import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/categories/data/datasources/category_remote_data_source_contract.dart';
import 'package:flower_app/features/app_sections/categories/data/models/category_dto.dart';
import 'package:flower_app/features/app_sections/categories/data/models/metadata_dto.dart';
import 'package:flower_app/features/app_sections/categories/data/repositories/categories_repo_impl.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// Generate the mock for the remote data source contract
@GenerateMocks([CategoriesRemoteDataSourceContract])
import 'categories_repo_impl_test.mocks.dart';

void main() {
  late CategoriesRepoImpl repository;
  late MockCategoriesRemoteDataSourceContract mockRemoteDataSource;

  // 1. ADD THIS BLOCK: Tell Mockito how to create a dummy BaseResponse
  setUpAll(() {
    provideDummy<BaseResponse<CategoryDto>>(
      SuccessBaseResponse<CategoryDto>(
        data: CategoryDto(
          message: 'dummy',
          metadata: MetadataDto(),
          categories: [],
        ),
      ),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockCategoriesRemoteDataSourceContract();
    repository = CategoriesRepoImpl(
      categoryRemoteDataSource: mockRemoteDataSource,
    );
  });

  // Prepare dummy data for the success case
  final tCategoryDto = CategoryDto(
    message: 'Success Message',
    metadata: MetadataDto(
      currentPage: 1,
      limit: 10,
      totalPages: 1,
      totalItems: 5,
    ),
    categories: [],
  );

  group('getCategories Repository Tests', () {
    test(
      'should return SuccessBaseResponse<CategoryEntity> and map DTO to Entity correctly',
      () async {
        // Arrange
        when(mockRemoteDataSource.getCategories()).thenAnswer(
          (_) async => SuccessBaseResponse<CategoryDto>(data: tCategoryDto),
        );

        // Act
        final result = await repository.getCategories();

        // Assert
        expect(result, isA<SuccessBaseResponse<CategoryEntity>>());
        final successResult = result as SuccessBaseResponse<CategoryEntity>;

        expect(successResult.data.message, equals(tCategoryDto.message));
        verify(mockRemoteDataSource.getCategories()).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse<CategoryEntity> when data source returns an error',
      () async {
        // Arrange
        const tErrorMessage = 'Something went wrong, please try again later';

        when(mockRemoteDataSource.getCategories()).thenAnswer(
          (_) async =>
              ErrorBaseResponse<CategoryDto>(errorMessage: tErrorMessage),
        );

        // Act
        final result = await repository.getCategories();

        // Assert
        expect(result, isA<ErrorBaseResponse<CategoryEntity>>());
        final errorResult = result as ErrorBaseResponse<CategoryEntity>;

        expect(errorResult.errorMessage, equals(tErrorMessage));
        expect(errorResult.errorMessage, isNotNull);

        verify(mockRemoteDataSource.getCategories()).called(1);
      },
    );
  });
}
