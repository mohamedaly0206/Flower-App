import 'package:flower_app/core/shared_features/intent/home_shared_intent.dart';
import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeSharedCubit extends Cubit<HomeSharedStates> {
  HomeSharedCubit() : super(HomeSharedStates());
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

  Future<void> _getBestSellers() async {}

  Future<void> _getProducts() async {}
}
