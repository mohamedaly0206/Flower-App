import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/Intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/app_sections/categories/domain/use_cases/categories_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeSharedCubit extends Cubit<HomeSharedStates> {
  HomeSharedCubit(this.categoriesUseCase) : super(HomeSharedStates());
  final CategoriesUseCase categoriesUseCase;
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
        _changeTab(intent);
    }
  }

  Future<void> _getAllHomeData() async {
    _getCategories();
    _getOccasions();
    _getBestSellers();
  }

  Future<void> _getCategories() async {
    emit(
      state.copyWith(
        categoriesState: state.categoriesState.copyWith(isLoadingParam: true),
      ),
    );
    final response = await categoriesUseCase.getCategories();
    switch (response) {
      case SuccessBaseResponse<CategoryEntity>():
        emit(
          state.copyWith(
            categoriesState: state.categoriesState.copyWith(
              dataParam: response.data,
              isLoadingParam: false,
            ),
          ),
        );
      case ErrorBaseResponse<CategoryEntity>():
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
  void _changeTab(ChangeTabIntent intent) {
  emit(state.copyWith(selectedIndex: intent.index));
}

  Future<void> _getOccasions() async {}

  Future<void> _getBestSellers() async {}
}
