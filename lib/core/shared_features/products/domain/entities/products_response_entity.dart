import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';

class ProductsResponseEntity {
  final String? message;
  final List<ProductEntity>? products;

  ProductsResponseEntity({this.message, this.products});
}
