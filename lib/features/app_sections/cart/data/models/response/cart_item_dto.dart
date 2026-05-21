import 'package:flower_app/core/shared_features/products/data/models/product_dto.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_item_dto.g.dart';

@JsonSerializable()
class CartItemDto {
  @JsonKey(name: "product")
  final ProductDTO? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  CartItemDto({this.product, this.price, this.quantity, this.id});

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);
  CartItemEntity toDomain() {
    return CartItemEntity(
      id: id,
      product: product?.toDomain(),
      price: price?.toDouble(),
      quantity: quantity,
    );
  }
}
