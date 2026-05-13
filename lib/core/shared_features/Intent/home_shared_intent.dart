sealed class HomeSharedIntent {}

class GetAllHomeDataIntent extends HomeSharedIntent {}

class GetCategoriesIntent extends HomeSharedIntent {}

class GetOccasionsIntent extends HomeSharedIntent {}

class GetBestSellersIntent extends HomeSharedIntent {}
class ChangeTabIntent extends HomeSharedIntent {
  final int index;
  ChangeTabIntent(this.index);
}