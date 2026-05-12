import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/app_sections/categories/domain/entities/category_entity.dart';

class HomeSharedStates extends Equatable {
  final BaseState<CategoryEntity> categoriesState;
  const HomeSharedStates({
    this.categoriesState=const BaseState()
    });
    HomeSharedStates copyWith({
      BaseState<CategoryEntity>? categoriesState,
    }) {
      return HomeSharedStates(
        categoriesState: categoriesState ?? this.categoriesState,
      );
    }

  @override
  List<Object> get props => [categoriesState];
}
