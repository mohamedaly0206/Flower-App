import 'package:flower_app/features/orders/domain/models/orders_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders.g.dart';

@JsonSerializable()
class Orders {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "user")
  String? user;
  @JsonKey(name: "orderItems")
  List<dynamic>? orderItems;
  @JsonKey(name: "totalPrice")
  int? totalPrice;
  @JsonKey(name: "paymentType")
  String? paymentType;
  @JsonKey(name: "isPaid")
  bool? isPaid;
  @JsonKey(name: "isDelivered")
  bool? isDelivered;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "orderNumber")
  String? orderNumber;
  @JsonKey(name: "__v")
  int? v;

  Orders({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => _$OrdersFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersToJson(this);
  OrdersModel toDomain() {
    final product = _firstProduct;

    return OrdersModel(
      id: id ?? '',
      orderNumber: orderNumber ?? '',
      totalPrice: (totalPrice ?? 0).toInt(),
      isDelivered: isDelivered ?? false,
      state: state ?? 'pending',
      createdAt: createdAt,
      updatedAt: updatedAt,
      isPaid: isPaid ?? false,
      productTitle: product?['title'] as String?,
      productImage: product?['imgCover'] as String?,
    );
  }

  Map<String, dynamic>? get _firstProduct {
    final firstItem = orderItems?.isNotEmpty == true ? orderItems!.first : null;
    if (firstItem is! Map) return null;

    final product = firstItem['product'];
    if (product is Map<String, dynamic>) return product;
    if (product is Map) return Map<String, dynamic>.from(product);

    return null;
  }
}
