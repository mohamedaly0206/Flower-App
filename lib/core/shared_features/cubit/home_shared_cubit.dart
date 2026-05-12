import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/data/models/products_response.dart';
import 'package:flower_app/core/shared_features/domain/use_cases/get_products_use_case.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeSharedCubit extends Cubit<HomeSharedState> {
  final GetProductsUseCase _getProductsUseCase;

  HomeSharedCubit(this._getProductsUseCase) : super(HomeSharedInitial());

  Future<void> getAllHomeData() async {}

  Future<void> getCategories() async {}

  Future<void> getOccasions() async {}

  Future<void> getBestSellers() async {}

  /// Fetches products filtered by the provided query parameters.
  ///
  /// Reusable across any screen — pass [categoryId] for Categories,
  /// [occasionId] for Occasions, or both for combined filtering.
  Future<void> getProducts({
    String? categoryId,
    String? occasionId,
  }) async {
    emit(const ProductsLoading());

    final result = await _getProductsUseCase(
      categoryId: categoryId,
      occasionId: occasionId,
    );

    switch (result) {
      case SuccessBaseResponse<ProductsResponse>():
        emit(ProductsSuccess(products: result.data.products ?? []));
      case ErrorBaseResponse<ProductsResponse>():
        emit(ProductsFailure(result.errorMessage));
    }
  }
}
