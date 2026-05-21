class AddToCartRequest {
  final String productId;
  final int? quantity;

  AddToCartRequest({
    required this.productId,
    this.quantity=1,
  });
}