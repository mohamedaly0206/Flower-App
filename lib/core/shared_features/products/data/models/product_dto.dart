import 'package:flower_app/core/shared_features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDTO {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "priceAfterDiscount")
  final int? priceAfterDiscount;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "__v")
  final int? v;
  @JsonKey(name: "favoriteId")
  final dynamic favoriteId;
  @JsonKey(name: "isInWishlist")
  final bool? isInWishlist;

  ProductDTO({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.favoriteId,
    this.isInWishlist,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
  ProductEntity toDomain() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      imageCover: imgCover,
      images: images,
      priceAfterDiscount: priceAfterDiscount,
      discount: discount,
      quantity: quantity,
    );
  }
}
