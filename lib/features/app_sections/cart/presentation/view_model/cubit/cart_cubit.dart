import 'dart:developer';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/add_item_to_cart_use_case.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/get_items_cart_use_case.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/remove_item_from_cart_use_case.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/update_cart_item_quantity_use_case.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/state/cart_state.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetItemsCartUseCase _getItemsCartUseCase;
  final AddItemToCartUseCase _addItemToCartUseCase;
  final RemoveItemFromCartUseCase _removeItemFromCartUseCase;
  final UpdateCartItemQuantityUseCase _updateCartItemQuantityInCartUseCase;

  CartCubit(
    this._getItemsCartUseCase,
    this._addItemToCartUseCase,
    this._removeItemFromCartUseCase,
    this._updateCartItemQuantityInCartUseCase,
  ) : super(CartState());

  void cartIntentHandler(CartIntent intent) async {
    switch (intent) {
      case GetCartItemsIntent():
        await _getItemsCart();
        break;
      case AddItemToCartIntent():
        await _addItemToCart(intent.request);
        break;
      case RemoveItemFromCartIntent():
        await _removeItemFromCart(intent.productId);
        break;
      case UpdateCartItemQuantityIntent():
        await _updateCartItemQuantityInCart(intent.productId, intent.quantity);
        break;
    }
  }

  Future<void> _getItemsCart() async {
    emit(
      state.copyWith(
        getCartItemsState: state.getCartItemsState?.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final response = await _getItemsCartUseCase();

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            getCartItemsState: state.getCartItemsState?.copyWith(
              dataParam: response.data,
              isLoadingParam: false,
            ),
          ),
        );
        log('items fetched successfully');
        break;
      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            getCartItemsState: state.getCartItemsState?.copyWith(
              errorMessageParam: response.errorMessage,
              isLoadingParam: false,
            ),
          ),
        );
        log('items fetch failed');
        break;
    }
  }

  Future<void> _addItemToCart(AddToCartRequest request) async {
    emit(
      state.copyWith(
        addItemToCartState: state.addItemToCartState?.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final response = await _addItemToCartUseCase(request);

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            addItemToCartState: state.addItemToCartState?.copyWith(
              dataParam: response.data,
              isLoadingParam: false,
            ),
            getCartItemsState: state.getCartItemsState?.copyWith(
              dataParam: response.data,
            ),
          ),
        );

        log('item added successfully');
        break;
      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            addItemToCartState: state.addItemToCartState?.copyWith(
              errorMessageParam: response.errorMessage,
              isLoadingParam: false,
            ),
          ),
        );
        log('item add failed');
        break;
    }
  }

  Future<void> _removeItemFromCart(String productId) async {
    emit(
      state.copyWith(
        removeItemFromCartState: state.removeItemFromCartState?.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final response = await _removeItemFromCartUseCase(productId);

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            removeItemFromCartState: state.removeItemFromCartState?.copyWith(
              dataParam: response.data,
              isLoadingParam: false,
            ),
            getCartItemsState: state.getCartItemsState?.copyWith(
              dataParam: response.data,
            ),
          ),
        );
        log('item removed successfully');
        break;
      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            removeItemFromCartState: state.removeItemFromCartState?.copyWith(
              errorMessageParam: response.errorMessage,
              isLoadingParam: false,
            ),
          ),
        );
        log('item remove failed');
        break;
    }
  }

  Future<void> _updateCartItemQuantityInCart(
    String productId,
    UpdateCartQuantityRequest request,
  ) async {
    emit(
      state.copyWith(
        updateItemQuantityInCartState: state.updateItemQuantityInCartState
            ?.copyWith(isLoadingParam: true),
      ),
    );

    final response = await _updateCartItemQuantityInCartUseCase(
      productId,
      UpdateCartQuantityRequest(quantity: request.quantity),
    );

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            updateItemQuantityInCartState: state.updateItemQuantityInCartState
                ?.copyWith(dataParam: response.data, isLoadingParam: false),
            getCartItemsState: state.getCartItemsState?.copyWith(
              dataParam: response.data,
            ),
          ),
        );
        log('quantity updated successfully');
        break;
      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            updateItemQuantityInCartState: state.updateItemQuantityInCartState
                ?.copyWith(
                  errorMessageParam: response.errorMessage,
                  isLoadingParam: false,
                ),
          ),
        );
        log('quantity update failed');
        log(response.errorMessage);
        break;
    }
  }
}
