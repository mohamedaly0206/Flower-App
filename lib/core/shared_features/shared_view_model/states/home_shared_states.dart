import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/app_sections/categories/presentation/widgets/product_sort_type.dart';

import '../../../../features/occasion/domain/entities/occasions_response_entity.dart';

class HomeSharedStates extends Equatable {
  final BaseState<OccasionsResponseEntity> occasionsState;
  final BaseState<CategoryEntity> categoriesState;
  final BaseState<ProductsResponseEntity> productsState;
  final BaseState<ProductsResponseEntity> bestSellersState;
  final int selectedIndex;
  final ProductSortType selectedSortType;
  final List<dynamic>? originalProducts;
  const HomeSharedStates({
    this.occasionsState = const BaseState(),
    this.productsState = const BaseState(),
    this.categoriesState = const BaseState(),
    this.bestSellersState = const BaseState(),
    this.selectedIndex = 0,
    this.selectedSortType = ProductSortType.newest,
    this.originalProducts,
  });
  HomeSharedStates copyWith({
    BaseState<CategoryEntity>? categoriesState,
    int? selectedIndex,
    BaseState<OccasionsResponseEntity>? occasionsState,
    BaseState<ProductsResponseEntity>? productsState,
    BaseState<ProductsResponseEntity>? bestSellersState,
    ProductSortType? selectedSortType,
    List<dynamic>? originalProducts,
  }) {
    return HomeSharedStates(
      categoriesState: categoriesState ?? this.categoriesState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      occasionsState: occasionsState ?? this.occasionsState,
      productsState: productsState ?? this.productsState,
      bestSellersState: bestSellersState ?? this.bestSellersState,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      originalProducts: originalProducts ?? this.originalProducts,
    );
  }

  @override
  List<Object> get props => [
    categoriesState,
    selectedIndex,
    occasionsState,
    productsState,
    bestSellersState,
    selectedSortType,
    ?originalProducts,
  ];
}
