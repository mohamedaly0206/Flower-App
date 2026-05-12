import 'package:flower_app/core/shared_features/data/models/product_dto.dart';

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

// ─── Products States ──────────────────────────────────────────────────────────

class ProductsLoading extends HomeSharedState {
  const ProductsLoading();
}

class ProductsSuccess extends HomeSharedState {
  final List<ProductDTO> products;

  const ProductsSuccess({required this.products});
}

class ProductsFailure extends HomeSharedState {
  final String errorMessage;

  const ProductsFailure(this.errorMessage);
}
