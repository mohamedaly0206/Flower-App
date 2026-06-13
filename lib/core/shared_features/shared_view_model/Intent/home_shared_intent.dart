import 'package:flower_app/features/app_sections/categories/presentation/widgets/product_sort_type.dart';

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

class SortProductsIntent extends HomeSharedIntent {
  final ProductSortType sortType;
  SortProductsIntent(this.sortType);
}
