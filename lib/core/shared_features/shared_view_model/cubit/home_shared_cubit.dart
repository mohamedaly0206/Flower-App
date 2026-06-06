import 'dart:async';
import 'dart:developer';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/core/shared_features/products/domain/use_cases/products_use_case.dart';
import 'package:flower_app/core/shared_features/shared_view_model/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/shared_view_model/states/home_shared_states.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/use_cases/categories_use_case.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/product_sort_bottom_sheet.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/product_sort_type.dart';
import 'package:flower_app/features/best_seller/domain/use_case/best_seller_use_case.dart';
import 'package:flower_app/features/occasion/domain/use_cases/get_occasions_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../features/occasion/domain/entities/occasions_response_entity.dart';

@injectable
class HomeSharedCubit extends Cubit<HomeSharedStates> {
  HomeSharedCubit(
    this.categoriesUseCase,
    this._getProductsUseCase,
    this._bestSellerUseCase,
    this._getOccasionsUseCase,
  ) : super(const HomeSharedStates());

  final CategoriesUseCase categoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;
  final BestSellerUseCase _bestSellerUseCase;
  final GetOccasionsUseCase _getOccasionsUseCase;

  Timer? _searchDebounce;

  void handleHomeSharedIntent(HomeSharedIntent intent) async {
    switch (intent) {
      case GetAllHomeDataIntent():
        await _getAllHomeData();
        break;

      case GetCategoriesIntent():
        await _getCategories();
        break;

      case GetOccasionsIntent():
        await _getOccasions();
        break;

      case GetBestSellersIntent():
        await _getBestSellers();
        break;

      case ChangeTabIntent():
        await _changeCategoriesTab(intent);
        break;

      case GetProductsIntent():
        await _getProducts(
          categoryId: intent.categoryId,
          occasionId: intent.occasionId,
        );
        break;

      case SearchIntent():
        _searchProducts(intent);
        break;
      case SortProductsIntent():
        _sortProductsList(intent.sortType);
        break;
    }
  }

  Future<void> _getAllHomeData() async {
    await Future.wait([_getCategories(), _getOccasions(), _getBestSellers()]);
  }

  Future<void> _getCategories() async {
    log('getting categories');

    if (isClosed) return;

    emit(
      state.copyWith(
        categoriesState: state.categoriesState.copyWith(isLoadingParam: true),
      ),
    );

    final response = await categoriesUseCase.getCategories();

    if (isClosed) return;

    switch (response) {
      case SuccessBaseResponse<CategoryEntity>():
        log('got categories successfully');

        if (isClosed) return;

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

        break;

      case ErrorBaseResponse<CategoryEntity>():
        log('error getting categories');
        log(response.errorMessage);

        if (isClosed) return;

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

  Future<void> _changeCategoriesTab(ChangeTabIntent intent) async {
    if (isClosed) return;

    emit(state.copyWith(selectedIndex: intent.index));

    final categories = state.categoriesState.data?.categories;

    if (categories == null || categories.isEmpty) return;

    final selectedCategory = categories[intent.index];

    await _getProducts(categoryId: selectedCategory.id);
  }

  Future<void> _getOccasions() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        occasionsState: state.occasionsState.copyWith(isLoadingParam: true),
      ),
    );

    final result = await _getOccasionsUseCase();

    if (isClosed) return;

    switch (result) {
      case SuccessBaseResponse<OccasionsResponseEntity>():
        emit(
          state.copyWith(
            occasionsState: state.occasionsState.copyWith(
              dataParam: result.data,
              isLoadingParam: false,
            ),
          ),
        );
        break;

      case ErrorBaseResponse<OccasionsResponseEntity>():
        emit(
          state.copyWith(
            occasionsState: state.occasionsState.copyWith(
              isLoadingParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _getProducts({
    String? categoryId,
    String? occasionId,
    String? search,
  }) async {
    if (isClosed) return;

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

    if (isClosed) return;

    switch (result) {
      case SuccessBaseResponse<ProductsResponseEntity>():
        if (isClosed) return;

        emit(
          state.copyWith(
            productsState: state.productsState.copyWith(
              dataParam: result.data,
              isLoadingParam: false,
            ),
            originalProducts: result.data.products,
            selectedSortType: ProductSortType.newest,
          ),
        );

        break;
      case ErrorBaseResponse<ProductsResponseEntity>():
        if (isClosed) return;

        emit(
          state.copyWith(
            productsState: state.productsState.copyWith(
              isLoadingParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );

        break;
    }
  }

  void _searchProducts(SearchIntent intent) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(seconds: 1), () async {
      if (isClosed) return;

      final keyword = intent.search.trim();

      if (keyword.isEmpty) {
        if (isClosed) return;

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

  Future<void> _getBestSellers() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        bestSellersState: state.bestSellersState.copyWith(isLoadingParam: true),
      ),
    );

    final result = await _bestSellerUseCase();

    if (isClosed) return;

    switch (result) {
      case SuccessBaseResponse<ProductsResponseEntity>():
        if (isClosed) return;

        emit(
          state.copyWith(
            bestSellersState: state.bestSellersState.copyWith(
              dataParam: result.data,
              isLoadingParam: false,
            ),
          ),
        );
        log(state.bestSellersState.data?.products?[0].title ?? 'Unknown');

        break;

      case ErrorBaseResponse<ProductsResponseEntity>():
        if (isClosed) return;

        emit(
          state.copyWith(
            bestSellersState: state.bestSellersState.copyWith(
              isLoadingParam: false,
              errorMessageParam: result.errorMessage,
            ),
          ),
        );

        break;
    }
  }

  void _sortProductsList(ProductSortType sortType) {
    final currentProducts = state.originalProducts;
    if (currentProducts == null || currentProducts.isEmpty) return;

    List<dynamic> sortedList = List.from(currentProducts);

    switch (sortType) {
      case ProductSortType.lowestPrice:
        sortedList.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
      case ProductSortType.highestPrice:
        sortedList.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
        break;
      case ProductSortType.newest:
        sortedList.sort((a, b) => (b.id ?? '').compareTo(a.id ?? ''));
        break;
      case ProductSortType.oldest:
        sortedList.sort((a, b) => (a.id ?? '').compareTo(b.id ?? ''));
        break;
      case ProductSortType.discount:
        sortedList.sort((a, b) => (b.discount ?? 0).compareTo(a.discount ?? 0));
        break;
    }

    if (isClosed) return;

    emit(
      state.copyWith(
        productsState: state.productsState.copyWith(
          dataParam: ProductsResponseEntity(products: sortedList.cast()),
        ),
        selectedSortType: sortType,
      ),
    );
  }

  void openFilterBottomSheet(BuildContext context) {
    showProductSortBottomSheet(
      context,
      currentSortType: state.selectedSortType,
      onSortSelected: (newSortType) {
        handleHomeSharedIntent(SortProductsIntent(newSortType));
      },
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();

    return super.close();
  }
}
