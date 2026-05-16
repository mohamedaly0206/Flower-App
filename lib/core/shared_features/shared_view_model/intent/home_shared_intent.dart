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

class ChangeTabIntent extends HomeSharedIntent {
  final int index;
  ChangeTabIntent(this.index);
}

class SearchIntent extends HomeSharedIntent {
  final String search;
  SearchIntent(this.search);
}
