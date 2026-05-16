import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/core/shared_features/products/api/api_client/products_api_client.dart';
import 'package:flower_app/core/shared_features/products/data/datasources/products_remote_data_source_contract.dart';
import 'package:flower_app/core/shared_features/products/data/models/products_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRemoteDataSourceContract)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSourceContract {
  final ProductsApiClient _productsApiClient;

  ProductsRemoteDataSourceImpl(this._productsApiClient);

  @override
  Future<BaseResponse<ProductsResponseDto>> getProducts({
    String? categoryId,
    String? occasionId,
    String? search,
  }) async {
    try {
      final response = await _productsApiClient.getProducts(
        categoryId: categoryId,
        occasionId: occasionId,
        search: search,
      );
      return SuccessBaseResponse<ProductsResponseDto>(data: response);
    } on Exception catch (e) {
      return ErrorBaseResponse<ProductsResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
