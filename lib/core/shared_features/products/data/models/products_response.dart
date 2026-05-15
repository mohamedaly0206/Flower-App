import 'package:flower_app/core/shared_features/products/data/models/product_dto.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponseDto {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'products')
  List<ProductDTO>? products;

  ProductsResponseDto({this.message, this.products});

  factory ProductsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseDtoToJson(this);
  ProductsResponseEntity toDomain() {
    return ProductsResponseEntity(
      message: message,
      products: products?.map((productDto) => productDto.toDomain()).toList(),
    );
  }
}
