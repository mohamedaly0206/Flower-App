import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/products/data/datasources/products_remote_data_source_contract.dart';
import 'package:flower_app/core/shared_features/products/data/models/products_response.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/core/shared_features/products/domain/repositories/products_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepoContract)
class ProductsRepositoryImpl implements ProductsRepoContract {
  final ProductsRemoteDataSourceContract _remoteDataSource;

  ProductsRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<ProductsResponseEntity>> getProducts({
    String? categoryId,
    String? occasionId,
    String? search,
  }) async {
    final response = await _remoteDataSource.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
      search: search,
    );
    switch (response) {
      case SuccessBaseResponse<ProductsResponseDto>():
        return SuccessBaseResponse<ProductsResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<ProductsResponseDto>():
        return ErrorBaseResponse<ProductsResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
