abstract class HomeSharedState {
  final List<dynamic>? categories;
  final List<dynamic>? occasions;
  final List<dynamic>? bestSellers;

  const HomeSharedState({this.categories, this.occasions, this.bestSellers});
}

class HomeSharedInitial extends HomeSharedState {
  const HomeSharedInitial();
}

class HomeSharedLoading extends HomeSharedState {
  const HomeSharedLoading({
    super.categories,
    super.occasions,
    super.bestSellers,
  });
}

class HomeSharedSuccess extends HomeSharedState {
  const HomeSharedSuccess({
    super.categories,
    super.occasions,
    super.bestSellers,
  });
}

class HomeSharedFailure extends HomeSharedState {
  final String errorMessage;

  const HomeSharedFailure(
    this.errorMessage, {
    super.categories,
    super.occasions,
    super.bestSellers,
  });
}
