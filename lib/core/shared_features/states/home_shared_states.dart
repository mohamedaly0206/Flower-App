abstract class HomeSharedState {
  const HomeSharedState();
}

class HomeSharedInitial extends HomeSharedState {}

class HomeSharedLoading extends HomeSharedState {}

class HomeSharedSuccess extends HomeSharedState {
  final List<dynamic>? categories;
  final List<dynamic>? occasions;
  final List<dynamic>? bestSellers;

  const HomeSharedSuccess({this.categories, this.occasions, this.bestSellers});
}

class HomeSharedFailure extends HomeSharedState {
  final String errorMessage;
  const HomeSharedFailure(this.errorMessage);
}
