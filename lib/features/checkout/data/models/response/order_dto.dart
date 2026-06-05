import 'package:flower_app/features/checkout/data/models/response/order_item_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/response/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';
@JsonSerializable()
class OrderDto {
    @JsonKey(name: "user")
    final String? user;
    @JsonKey(name: "orderItems")
    final List<OrderItemDto>? orderItems;
    @JsonKey(name: "totalPrice")
    final double? totalPrice;
    @JsonKey(name: "paymentType")
    final String? paymentType;
    @JsonKey(name: "isPaid")
    final bool? isPaid;
    @JsonKey(name: "isDelivered")
    final bool? isDelivered;
    @JsonKey(name: "state")
    final String? state;
    @JsonKey(name: "_id")
    final String? id;
    @JsonKey(name: "createdAt")
    final DateTime? createdAt;
    @JsonKey(name: "updatedAt")
    final DateTime? updatedAt;
    @JsonKey(name: "orderNumber")
    final String? orderNumber;
    @JsonKey(name: "__v")
    final int? v;

    OrderDto({
        this.user,
        this.orderItems,
        this.totalPrice,
        this.paymentType,
        this.isPaid,
        this.isDelivered,
        this.state,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.orderNumber,
        this.v,
    });

    factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

    Map<String, dynamic> toJson() => _$OrderDtoToJson(this);
    OrderEntity toDomain() {
      return OrderEntity(
        user: user,
        orderItems: orderItems?.map((item) => item.toDomain()).toList(),
        totalPrice: totalPrice,
        paymentType: paymentType,
        isPaid: isPaid,
        isDelivered: isDelivered,
        state: state,
        id: id,
        orderNumber: orderNumber,
      );
    }
}