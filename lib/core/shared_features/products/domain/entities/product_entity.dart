class ProductEntity {
  final String? id;
  final String? title;
  final String? description;
  final int? price;
  final String? imageCover;
  final List<String>? images;
  final int? priceAfterDiscount;
  final int? discount;
  final int? quantity;

  ProductEntity({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageCover,
    this.images,
    this.priceAfterDiscount,
    this.discount,
    this.quantity,
  });
}
