sealed class HomeSharedIntent {}

class GetAllHomeDataIntent extends HomeSharedIntent {}

class GetCategoriesIntent extends HomeSharedIntent {}

class GetOccasionsIntent extends HomeSharedIntent {}

class GetBestSellersIntent extends HomeSharedIntent {}

class GetProductsIntent extends HomeSharedIntent {
  final String? categoryId;
  final String? occasionId;

  GetProductsIntent({this.categoryId, this.occasionId});
}

