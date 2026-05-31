import 'package:flower_app/features/app_sections/cart/data/models/response/cart_item_dto.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "cartItems")
  final List<CartItemDto>? cartItems;
  @JsonKey(name: "appliedCoupons")
  final List<dynamic>? appliedCoupons;
  @JsonKey(name: "discount")
  final int? discount;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "totalPriceAfterDiscount")
  final int? totalPriceAfterDiscount;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime? updatedAt;
  @JsonKey(name: "__v")
  final int? v;

  CartDto({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.discount,
    this.totalPrice,
    this.totalPriceAfterDiscount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
  CartEntity toDomain() {
    return CartEntity(
      id: id,
      user: user,
      cartItems: cartItems?.map((item) => item.toDomain()).toList(),
      appliedCoupons: appliedCoupons,
      discount: discount?.toDouble(),
      totalPriceAfterDiscount: totalPriceAfterDiscount?.toDouble(),
    );
  }
}
