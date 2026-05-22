import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_request.g.dart';

@JsonSerializable()
class AddToCartRequest {
  @JsonKey(
    name: 'product',
  ) // Double-check if your backend expects 'productId' or 'product'
  final String productId;

  @JsonKey(name: 'quantity')
  final int? quantity;

  AddToCartRequest({required this.productId, this.quantity = 1});

  factory AddToCartRequest.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartRequestToJson(this);
}
