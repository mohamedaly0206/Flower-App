import 'package:flower_app/core/shared_features/data/models/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'products')
  List<ProductDTO>? products;

  ProductsResponse({
    this.message,
    this.products,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsResponseToJson(this);
}
