import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared_features/data/models/product_dto.dart';

class HomeSharedStates extends Equatable {
  final BaseState<List<dynamic>> categoriesState;
  final BaseState<List<dynamic>> occasionsState;
  final BaseState<List<dynamic>> bestSellersState;
  final BaseState<List<ProductDTO>> productsState;

  const HomeSharedStates({
    this.categoriesState = const BaseState(),
    this.occasionsState = const BaseState(),
    this.bestSellersState = const BaseState(),
    this.productsState = const BaseState(),
  });

  HomeSharedStates copyWith({
    BaseState<List<dynamic>>? categoriesState,
    BaseState<List<dynamic>>? occasionsState,
    BaseState<List<dynamic>>? bestSellersState,
    BaseState<List<ProductDTO>>? productsState,
  }) {
    return HomeSharedStates(
      categoriesState: categoriesState ?? this.categoriesState,
      occasionsState: occasionsState ?? this.occasionsState,
      bestSellersState: bestSellersState ?? this.bestSellersState,
      productsState: productsState ?? this.productsState,
    );
  }

  @override
  List<Object?> get props => [
        categoriesState,
        occasionsState,
        bestSellersState,
        productsState,
      ];
}
