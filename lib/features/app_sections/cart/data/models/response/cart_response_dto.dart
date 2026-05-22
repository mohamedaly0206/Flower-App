import 'package:flower_app/features/app_sections/cart/data/models/response/cart_dto.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_response_dto.g.dart';

@JsonSerializable()
class CartResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final CartDto? cart;

  CartResponseDto({this.message, this.numOfCartItems, this.cart});

  factory CartResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CartResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseDtoToJson(this);
  CartResponseEntity toDomain() {
    return CartResponseEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart?.toDomain(),
    );
  }
}
