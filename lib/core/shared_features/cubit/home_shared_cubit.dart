import 'package:flower_app/core/shared_features/states/home_shared_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeSharedCubit extends Cubit<HomeSharedState> {
  HomeSharedCubit() : super(HomeSharedInitial());

  Future<void> getAllHomeData() async {}

  Future<void> getCategories() async {}

  Future<void> getOccasions() async {}

  Future<void> getBestSellers() async {}
}
