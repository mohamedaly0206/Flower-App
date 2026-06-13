class OrdersModel {
  final String? id;
  final String? orderNumber;
  final int? totalPrice;
  final bool? isDelivered;
  final String? state;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isPaid;
  final String? productTitle;
  final String? productImage;

  OrdersModel({
    required this.id,
    required this.orderNumber,
    required this.totalPrice,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.isPaid,
    this.productTitle,
    this.productImage,
  });
}
