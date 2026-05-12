import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDTO {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'slug')
  String? slug;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'imgCover')
  String? imageCover;

  @JsonKey(name: 'images')
  List<String>? images;

  @JsonKey(name: 'price')
  num? price;

  @JsonKey(name: 'priceAfterDiscount')
  num? priceAfterDiscount;

  @JsonKey(name: 'quantity')
  int? quantity;

  @JsonKey(name: 'sold')
  int? sold;

  @JsonKey(name: 'ratingsAverage')
  num? ratingsAverage;

  @JsonKey(name: 'ratingsQuantity')
  int? ratingsQuantity;

  @JsonKey(name: 'category')
  String? category;

  @JsonKey(name: 'occasion')
  String? occasion;

  @JsonKey(name: 'isSuperAdmin')
  bool? isSuperAdmin;

  @JsonKey(name: 'createdAt')
  DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;

  ProductDTO({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imageCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.sold,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
}
