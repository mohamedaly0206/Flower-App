import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../state/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
}
