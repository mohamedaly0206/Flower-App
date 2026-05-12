import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/core/shared_features/data/datasources/products_remote_data_source.dart';
import 'package:flower_app/core/shared_features/data/models/products_response.dart';
import 'package:flower_app/core/shared_features/domain/repo/products_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRepository)
class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource _remoteDataSource;

  ProductsRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<ProductsResponse>> getProducts({
    String? categoryId,
    String? occasionId,
  }) async {
    try {
      final response = await _remoteDataSource.getProducts(
        categoryId: categoryId,
        occasionId: occasionId,
      );
      return SuccessBaseResponse(data: response);
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }
}
