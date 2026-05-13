import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';

class HomeSharedStates extends Equatable {
  final BaseState<CategoryEntity> categoriesState;
  final int selectedIndex;
  const HomeSharedStates({
    this.categoriesState = const BaseState(),
    this.selectedIndex = 0,
  });
  HomeSharedStates copyWith({
    BaseState<CategoryEntity>? categoriesState,
    int? selectedIndex,
  }) {
    return HomeSharedStates(
      categoriesState: categoriesState ?? this.categoriesState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [categoriesState, selectedIndex];
}
