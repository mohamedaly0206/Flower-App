import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/data/models/products_response.dart';

abstract class ProductsRepository {
  Future<BaseResponse<ProductsResponse>> getProducts({
    String? categoryId,
    String? occasionId,
  });
}
