import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/data/models/products_response.dart';
import 'package:flower_app/core/shared_features/domain/use_cases/get_products_use_case.dart';
import 'package:flower_app/core/shared_features/intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeSharedCubit extends Cubit<HomeSharedStates> {
  final GetProductsUseCase _getProductsUseCase;

  HomeSharedCubit(this._getProductsUseCase) : super(const HomeSharedStates());

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
      case GetProductsIntent():
        _getProducts(
          categoryId: intent.categoryId,
          occasionId: intent.occasionId,
        );
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

  Future<void> _getBestSellers() async {}

  Future<void> _getProducts({String? categoryId, String? occasionId}) async {
    emit(state.copyWith(
      productsState: state.productsState.copyWith(isLoadingParam: true),
    ));

    final result = await _getProductsUseCase(
      categoryId: categoryId,
      occasionId: occasionId,
    );

    switch (result) {
      case SuccessBaseResponse<ProductsResponse>():
        emit(state.copyWith(
          productsState: state.productsState.copyWith(
            isLoadingParam: false,
            dataParam: result.data.products ?? [],
          ),
        ));
      case ErrorBaseResponse<ProductsResponse>():
        emit(state.copyWith(
          productsState: state.productsState.copyWith(
            isLoadingParam: false,
            errorMessageParam: result.errorMessage,
          ),
        ));
    }
  }
}
