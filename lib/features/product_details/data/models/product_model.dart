class ProductModel {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final num? price;
  final num? priceAfterDiscount;
  final num? discount;
  final num? rateAvg;
  final num? rateCount;
  final num? sold;
  final num? quantity;
  final String? category;
  final String? occasion;
  final bool? isSuperAdmin;
  final String? createdAt;
  final String? updatedAt;
  final String? favoriteId;
  final bool? isInWishlist;

  ProductModel({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.favoriteId,
    this.isInWishlist,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      imgCover: json['imgCover'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      price: json['price'],
      priceAfterDiscount: json['priceAfterDiscount'],
      discount: json['discount'],
      rateAvg: json['rateAvg'],
      rateCount: json['rateCount'],
      sold: json['sold'],
      quantity: json['quantity'],
      category: json['category'],
      occasion: json['occasion'],
      isSuperAdmin: json['isSuperAdmin'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      favoriteId: json['favoriteId'],
      isInWishlist: json['isInWishlist'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'imgCover': imgCover,
      'images': images,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'discount': discount,
      'rateAvg': rateAvg,
      'rateCount': rateCount,
      'sold': sold,
      'quantity': quantity,
      'category': category,
      'occasion': occasion,
      'isSuperAdmin': isSuperAdmin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'favoriteId': favoriteId,
      'isInWishlist': isInWishlist,
    };
  }
}
