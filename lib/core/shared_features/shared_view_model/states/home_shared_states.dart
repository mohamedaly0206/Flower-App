import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_model.dart';

class HomeSharedStates extends Equatable {
  final BaseState<ProductsResponseEntity> occasionsState;
  final BaseState<CategoryEntity> categoriesState;
  final BaseState<ProductsResponseEntity> productsState;
  final BaseState<List<BestSellerModel>> bestSellersState;
  final int selectedIndex;
  const HomeSharedStates({
    this.occasionsState = const BaseState(),
    this.productsState = const BaseState(),
    this.categoriesState = const BaseState(),
    this.bestSellersState = const BaseState(),
    this.selectedIndex = 0,
  });
  HomeSharedStates copyWith({
    BaseState<CategoryEntity>? categoriesState,
    int? selectedIndex,
    BaseState<ProductsResponseEntity>? occasionsState,
    BaseState<ProductsResponseEntity>? productsState,
    BaseState<List<BestSellerModel>>? bestSellersState,
  }) {
    return HomeSharedStates(
      categoriesState: categoriesState ?? this.categoriesState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      occasionsState: occasionsState ?? this.occasionsState,
      productsState: productsState ?? this.productsState,
      bestSellersState: bestSellersState ?? this.bestSellersState,
    );
  }

  @override
  List<Object> get props => [
    categoriesState,
    selectedIndex,
    occasionsState,
    productsState,
    bestSellersState
  ];
}
