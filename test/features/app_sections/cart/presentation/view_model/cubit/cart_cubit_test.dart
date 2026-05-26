import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/add_item_to_cart_use_case.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/get_items_cart_use_case.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/remove_item_from_cart_use_case.dart';
import 'package:flower_app/features/app_sections/cart/domain/use_cases/update_cart_item_quantity_use_case.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/intent/cart_intent.dart';
import 'package:flower_app/features/app_sections/cart/presentation/view_model/state/cart_state.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([
  GetItemsCartUseCase,
  AddItemToCartUseCase,
  RemoveItemFromCartUseCase,
  UpdateCartItemQuantityUseCase,
])
void main() {
  late MockGetItemsCartUseCase mockGetItemsUseCase;
  late MockAddItemToCartUseCase mockAddItemUseCase;
  late MockRemoveItemFromCartUseCase mockRemoveItemUseCase;
  late MockUpdateCartItemQuantityUseCase mockUpdateQuantityUseCase;

  final tCartEntity = CartResponseEntity();

  setUpAll(() {
    provideDummy<BaseResponse<CartResponseEntity>>(
      SuccessBaseResponse<CartResponseEntity>(data: tCartEntity),
    );
  });

  setUp(() {
    mockGetItemsUseCase = MockGetItemsCartUseCase();
    mockAddItemUseCase = MockAddItemToCartUseCase();
    mockRemoveItemUseCase = MockRemoveItemFromCartUseCase();
    mockUpdateQuantityUseCase = MockUpdateCartItemQuantityUseCase();
  });

  group('CartCubit - GetCartItems', () {
    blocTest<CartCubit, CartState>(
      'emits [loading, success] when GetCartItemsIntent is successful',
      setUp: () {
        when(mockGetItemsUseCase.call()).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseEntity>(data: tCartEntity),
        );
      },
      build: () => CartCubit(
        mockGetItemsUseCase,
        mockAddItemUseCase,
        mockRemoveItemUseCase,
        mockUpdateQuantityUseCase,
      ),
      act: (cubit) => cubit.cartIntentHandler(GetCartItemsIntent()),
      expect: () => [
        isA<CartState>().having(
          (s) => s.getCartItemsState?.isLoading,
          'isLoading',
          true,
        ),
        isA<CartState>().having(
          (s) => s.getCartItemsState?.data,
          'data',
          tCartEntity,
        ),
      ],
    );
  });

  group('CartCubit - AddItemToCart', () {
    final tRequest = AddToCartRequest(productId: '123', quantity: 1);

    blocTest<CartCubit, CartState>(
      'emits [loading, success] when AddItemToCartIntent is successful',
      setUp: () {
        when(mockAddItemUseCase.call(any)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseEntity>(data: tCartEntity),
        );
      },
      build: () => CartCubit(
        mockGetItemsUseCase,
        mockAddItemUseCase,
        mockRemoveItemUseCase,
        mockUpdateQuantityUseCase,
      ),
      act: (cubit) =>
          cubit.cartIntentHandler(AddItemToCartIntent(request: tRequest)),
      expect: () => [
        isA<CartState>().having(
          (s) => s.addItemToCartState?.isLoading,
          'isLoading',
          true,
        ),
        isA<CartState>().having(
          (s) => s.addItemToCartState?.data,
          'data',
          tCartEntity,
        ),
      ],
    );
  });

  group('CartCubit - RemoveItemFromCart', () {
    const tProductId = '123';

    blocTest<CartCubit, CartState>(
      'emits [loading, success] when RemoveItemFromCartIntent is successful',
      setUp: () {
        when(mockRemoveItemUseCase.call(any)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseEntity>(data: tCartEntity),
        );
      },
      build: () => CartCubit(
        mockGetItemsUseCase,
        mockAddItemUseCase,
        mockRemoveItemUseCase,
        mockUpdateQuantityUseCase,
      ),
      act: (cubit) => cubit.cartIntentHandler(
        RemoveItemFromCartIntent(productId: tProductId),
      ),
      expect: () => [
        isA<CartState>().having(
          (s) => s.removeItemFromCartState?.isLoading,
          'isLoading',
          true,
        ),
        isA<CartState>().having(
          (s) => s.removeItemFromCartState?.data,
          'data',
          tCartEntity,
        ),
      ],
    );
  });

  group('CartCubit - UpdateCartItemQuantity', () {
    const tProductId = '123';
    final tRequest = UpdateCartQuantityRequest(quantity: 2);

    blocTest<CartCubit, CartState>(
      'emits [loading, success] when UpdateCartItemQuantityIntent is successful',
      setUp: () {
        when(mockUpdateQuantityUseCase.call(any, any)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseEntity>(data: tCartEntity),
        );
      },
      build: () => CartCubit(
        mockGetItemsUseCase,
        mockAddItemUseCase,
        mockRemoveItemUseCase,
        mockUpdateQuantityUseCase,
      ),
      act: (cubit) => cubit.cartIntentHandler(
        UpdateCartItemQuantityIntent(productId: tProductId, quantity: tRequest),
      ),
      expect: () => [
        isA<CartState>().having(
          (s) => s.updateItemQuantityInCartState?.isLoading,
          'isLoading',
          true,
        ),
        isA<CartState>().having(
          (s) => s.updateItemQuantityInCartState?.data,
          'data',
          tCartEntity,
        ),
      ],
    );
  });
}
