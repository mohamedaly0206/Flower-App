import 'package:flower_app/core/shared_features/data/models/products_response.dart';

abstract interface class ProductsRemoteDataSource {
  Future<ProductsResponse> getProducts({
    String? categoryId,
    String? occasionId,
  });
}
