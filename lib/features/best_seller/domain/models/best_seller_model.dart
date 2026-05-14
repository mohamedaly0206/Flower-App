class BestSellerModel {
  final String id;
  final String title;
  final String? imgCover;
  final int price;
  final int priceAfterDiscount;
  final int discount;

  BestSellerModel({
    required this.id,
    required this.title,
    required this.imgCover,
    required this.price,
    required this.priceAfterDiscount,
    required this.discount,
  });
}
