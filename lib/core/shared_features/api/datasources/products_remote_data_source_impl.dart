import 'package:flower_app/core/shared_features/api/products_api_client/products_api_client.dart';
import 'package:flower_app/core/shared_features/data/datasources/products_remote_data_source.dart';
import 'package:flower_app/core/shared_features/data/models/products_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsRemoteDataSource)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ProductsApiClient _productsApiClient;

  ProductsRemoteDataSourceImpl(this._productsApiClient);

  @override
  Future<ProductsResponse> getProducts({
    String? categoryId,
    String? occasionId,
  }) {
    return _productsApiClient.getProducts(
      categoryId: categoryId,
      occasionId: occasionId,
    );
  }
}
