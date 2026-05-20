import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../state/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
}
