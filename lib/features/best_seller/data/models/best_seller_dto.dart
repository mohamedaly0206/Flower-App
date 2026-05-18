import 'package:flower_app/core/shared_features/products/data/models/product_dto.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'best_seller_dto.g.dart';

BestSellerDto bestSellerDtoFromJson(String str) =>
    BestSellerDto.fromJson(json.decode(str));

String bestSellerDtoToJson(BestSellerDto data) => json.encode(data.toJson());

@JsonSerializable()
class BestSellerDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "bestSeller")
  final List<ProductDTO>? bestSeller;

  BestSellerDto({this.message, this.bestSeller});
  ProductsResponseEntity toDomain() {
    return ProductsResponseEntity(
      message: message,
      products:
          bestSeller?.map((element) {
            return element.toDomain();
          }).toList() ??
          [],
    );
  }

  factory BestSellerDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerDtoToJson(this);
}
