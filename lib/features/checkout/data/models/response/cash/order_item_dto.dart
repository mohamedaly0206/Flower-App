import 'package:flower_app/core/shared_features/products/data/models/product_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/response/cash/order_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_dto.g.dart';

@JsonSerializable()
class OrderItemDto {
  @JsonKey(name: "product")
  final ProductDTO? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  OrderItemDto({this.product, this.price, this.quantity, this.id});

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);
  OrderItemEntity toDomain() {
    return OrderItemEntity(
      product: product?.toDomain(),
      price: price?.toDouble(),
      quantity: quantity,
    );
  }
}
