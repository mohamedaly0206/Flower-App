import 'package:equatable/equatable.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final String? id;
  final ProductEntity? product;
  final int? quantity;
  final double? price;

  const CartItemEntity({this.id, this.product, this.quantity, this.price});

  @override
  List<Object?> get props => [id, product, quantity, price];
}
