class UpdateCartQuantityRequest {
  final int quantity;

  UpdateCartQuantityRequest({required this.quantity});

  Map<String, dynamic> toJson() => {'quantity': quantity};
}
