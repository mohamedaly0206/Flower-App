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

@singleton
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
  ) : super(const CartState());

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
        break;
    }
  }

  Future<void> _addItemToCart(AddToCartRequest request) async {
    emit(
      state.copyWith(
        loadingProductIds: {...state.loadingProductIds, request.productId},
        addItemToCartState: state.addItemToCartState?.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final response = await _addItemToCartUseCase(request);

    final updatedLoadingSet = Set<String>.from(state.loadingProductIds)
      ..remove(request.productId);

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            loadingProductIds: updatedLoadingSet,
            addItemToCartState: state.addItemToCartState?.copyWith(
              dataParam: response.data,
              isLoadingParam: false,
            ),
            getCartItemsState: state.getCartItemsState?.copyWith(
              dataParam: response.data,
            ),
          ),
        );
        break;

      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            loadingProductIds: updatedLoadingSet,
            addItemToCartState: state.addItemToCartState?.copyWith(
              errorMessageParam: response.errorMessage,
              isLoadingParam: false,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _removeItemFromCart(String productId) async {
    emit(
      state.copyWith(
        // Add ID to deleting set
        deletingProductIds: {...state.deletingProductIds, productId},
        removeItemFromCartState: state.removeItemFromCartState?.copyWith(
          isLoadingParam: true,
        ),
      ),
    );

    final response = await _removeItemFromCartUseCase(productId);

    // Remove ID from deleting set
    final updatedDeletingSet = Set<String>.from(state.deletingProductIds)
      ..remove(productId);

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            deletingProductIds: updatedDeletingSet, // Emit new set
            removeItemFromCartState: state.removeItemFromCartState?.copyWith(
              dataParam: response.data,
              isLoadingParam: false,
            ),
            getCartItemsState: state.getCartItemsState?.copyWith(
              dataParam: response.data,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            deletingProductIds: updatedDeletingSet, // Emit new set
            removeItemFromCartState: state.removeItemFromCartState?.copyWith(
              errorMessageParam: response.errorMessage,
              isLoadingParam: false,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _updateCartItemQuantityInCart(
    String productId,
    UpdateCartQuantityRequest request,
  ) async {
    emit(
      state.copyWith(
        // Add ID to updating set
        updatingProductIds: {...state.updatingProductIds, productId},
        updateItemQuantityInCartState: state.updateItemQuantityInCartState
            ?.copyWith(isLoadingParam: true),
      ),
    );

    final response = await _updateCartItemQuantityInCartUseCase(
      productId,
      UpdateCartQuantityRequest(quantity: request.quantity),
    );

    // Remove ID from updating set
    final updatedUpdatingSet = Set<String>.from(state.updatingProductIds)
      ..remove(productId);

    switch (response) {
      case SuccessBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            updatingProductIds: updatedUpdatingSet, // Emit new set
            updateItemQuantityInCartState: state.updateItemQuantityInCartState
                ?.copyWith(dataParam: response.data, isLoadingParam: false),
            getCartItemsState: state.getCartItemsState?.copyWith(
              dataParam: response.data,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<CartResponseEntity>():
        emit(
          state.copyWith(
            updatingProductIds: updatedUpdatingSet, // Emit new set
            updateItemQuantityInCartState: state.updateItemQuantityInCartState
                ?.copyWith(
                  errorMessageParam: response.errorMessage,
                  isLoadingParam: false,
                ),
          ),
        );
        break;
    }
  }
}
