import 'package:equatable/equatable.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';

class OrderItemEntity extends Equatable {
    final ProductEntity? product;
    final double? price;
    final int? quantity;
    final String? id;

    const OrderItemEntity({
        this.product,
        this.price,
        this.quantity,
        this.id,
    });

    @override
    List<Object?> get props => [product, price, quantity, id];
}