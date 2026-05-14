import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_model.dart';

class HomeSharedStates extends Equatable {
  //example for state class
  // final BaseState<CategoryEntity> categoriesState;
  final BaseState<List<BestSellerModel>> bestSellersState;
  const HomeSharedStates({this.bestSellersState = const BaseState()});
  // HomeSharedStates copyWith({
  // }) {
  //   return HomeSharedStates(

  //   );
  // }
  HomeSharedStates copyWith({
    BaseState<List<BestSellerModel>>? bestSellersState,
  }) {
    return HomeSharedStates(
      bestSellersState: bestSellersState ?? this.bestSellersState,
    );
  }

  @override
  List<Object> get props => [bestSellersState];
}
