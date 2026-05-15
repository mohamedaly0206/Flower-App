import 'dart:async';
import 'dart:developer';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/core/shared_features/products/domain/use_cases/products_use_case.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/use_cases/categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeSharedCubit extends Cubit<HomeSharedStates> {
  HomeSharedCubit(this.categoriesUseCase, this._getProductsUseCase)
    : super(HomeSharedStates());
  final CategoriesUseCase categoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;
  Timer? _searchDebounce;

  void handleHomeSharedIntent(HomeSharedIntent intent) {
    switch (intent) {
      case GetAllHomeDataIntent():
        _getAllHomeData();
        break;
      case GetCategoriesIntent():
        _getCategories();
        break;
      case GetOccasionsIntent():
        _getOccasions();
        break;
      case GetBestSellersIntent():
        _getBestSellers();
        break;
      case ChangeTabIntent():
        _changeCategoriesTab(intent);
        break;
      case GetProductsIntent():
        _getProducts(
          categoryId: intent.categoryId,
          occasionId: intent.occasionId,
        );
        break;
      case SearchIntent():
        _searchProducts(intent);
        break;
    }
  }

  Future<void> _getAllHomeData() async {
    _getCategories();
    _getOccasions();
    _getBestSellers();
  }

  Future<void> _getCategories() async {
    log('getting categories');
    emit(
      state.copyWith(
        categoriesState: state.categoriesState.copyWith(isLoadingParam: true),
      ),
    );
    final response = await categoriesUseCase.getCategories();
    switch (response) {
      case SuccessBaseResponse<CategoryEntity>():
        log('got categories successfully');
        emit(
          state.copyWith(
            categoriesState: state.categoriesState.copyWith(
              dataParam: response.data,
              isLoadingParam: false,
            ),
          ),
        );
        final firstCategoryId = response.data.categories.firstOrNull?.id;

        if (firstCategoryId != null) {
          await _getProducts(categoryId: firstCategoryId);
        }
      case ErrorBaseResponse<CategoryEntity>():
        log('error getting categories');
        log(response.errorMessage);

        emit(
          state.copyWith(
            categoriesState: state.categoriesState.copyWith(
              isLoadingParam: false,
              errorMessageParam: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  void _changeCategoriesTab(ChangeTabIntent intent) async {
    emit(state.copyWith(selectedIndex: intent.index));

    final categories = state.categoriesState.data?.categories;

    if (categories == null || categories.isEmpty) return;

    final selectedCategory = categories[intent.index];

    await _getProducts(categoryId: selectedCategory.id);
  }

  Future<void> _getOccasions() async {}

  Future<void> _getBestSellers() async {}
  Future<void> _getProducts({
    String? categoryId,
    String? occasionId,
    String? search,
  }) async {
    emit(
      state.copyWith(
        productsState: state.productsState.copyWith(isLoadingParam: true),
      ),
    );

    final result = await _getProductsUseCase(
      categoryId: categoryId,
      occasionId: occasionId,
      search: search,
    );

    switch (result) {
      case SuccessBaseResponse<ProductsResponseEntity>():
        emit(
          state.copyWith(
            productsState: state.productsState.copyWith(
              dataParam: result.data,
              isLoadingParam: false,
            ),
          ),
        );
      case ErrorBaseResponse<ProductsResponseEntity>():
        emit(
          state.copyWith(
            productsState: state.productsState.copyWith(
              isLoadingParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
    }
  }

  void _searchProducts(SearchIntent intent) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(seconds: 1), () async {
      final keyword = intent.search.trim();

      if (keyword.isEmpty) {
        emit(
          state.copyWith(
            productsState: state.productsState.copyWith(
              dataParam: ProductsResponseEntity(products: []),
            ),
          ),
        );
        return;
      }

      await _getProducts(search: keyword);
    });
  }
}
