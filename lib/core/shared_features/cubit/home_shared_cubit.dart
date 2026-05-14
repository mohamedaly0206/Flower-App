import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/shared_features/intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_model.dart';
import 'package:flower_app/features/best_seller/domain/use_case/best_seller_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeSharedCubit extends Cubit<HomeSharedStates> {
  final BestSellerUseCase _bestSellerUseCase;

  HomeSharedCubit(this._bestSellerUseCase) : super(HomeSharedStates());

  Future<void> handleHomeSharedIntent(HomeSharedIntent intent) async{
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
      case GetProductsIntent():
        _getProducts();
        break;
    }
  }

  Future<void> _getAllHomeData() async {
    _getCategories();
    _getOccasions();
    _getBestSellers();
  }

  Future<void> _getCategories() async {}

  Future<void> _getOccasions() async {}

  Future<void> _getBestSellers() async {
    if (state.bestSellersState.isLoading) return;

    emit(
      state.copyWith(
        bestSellersState: const BaseState<List<BestSellerModel>>(
          isLoading: true,
        ),
      ),
    );

    final result = await _bestSellerUseCase();

    switch (result) {
      case SuccessBaseResponse<List<BestSellerModel>>():
        emit(
          state.copyWith(
            bestSellersState: BaseState<List<BestSellerModel>>(
              data: result.data,
            ),
          ),
        );
      case ErrorBaseResponse<List<BestSellerModel>>():
        emit(
          state.copyWith(
            bestSellersState: BaseState<List<BestSellerModel>>(
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _getProducts() async {}
}
