import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';

class CartItemEntity {
  final String? id;
  final ProductEntity? product;
  final int? quantity;
  final double? price;

  CartItemEntity({this.id, this.product, this.quantity, this.price});
}
