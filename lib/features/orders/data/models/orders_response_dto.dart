import 'package:flower_app/features/orders/data/models/meta_data.dart';
import 'package:flower_app/features/orders/data/models/orders.dart';
import 'package:json_annotation/json_annotation.dart';
part 'orders_response_dto.g.dart';

@JsonSerializable()
class OrdersResponseDto {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "metadata")
  Metadata? metadata;
  @JsonKey(name: "orders")
  List<Orders>? orders;

  OrdersResponseDto({this.message, this.metadata, this.orders});

  factory OrdersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseDtoToJson(this);
}
