import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/products/data/models/product_dto.dart';
import 'package:flower_app/features/app_sections/cart/data/data_sources/cart_remote_data_source_contract.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/response/cart_dto.dart';
import 'package:flower_app/features/app_sections/cart/data/models/response/cart_item_dto.dart';
import 'package:flower_app/features/app_sections/cart/data/models/response/cart_response_dto.dart';
import 'package:flower_app/features/app_sections/cart/data/repositories/cart_repo_impl.dart';
import 'package:flower_app/features/app_sections/cart/domain/entities/cart_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CartRemoteDataSourceContract])
import 'cart_repo_impl_test.mocks.dart';

void main() {
  late CartRepoImpl repository;
  late MockCartRemoteDataSourceContract mockRemoteDataSource;

  // Real instances for default testing
  // Adjust these constructors to match your actual DTO implementation
  final tEmptyCartResponseDto = CartResponseDto(
    numOfCartItems: 0,
    cart: CartDto(cartItems: []), // Assuming you have a nested CartDto
  );

  setUpAll(() {
    provideDummy<BaseResponse<CartResponseDto>>(
      SuccessBaseResponse<CartResponseDto>(data: tEmptyCartResponseDto),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockCartRemoteDataSourceContract();
    repository = CartRepoImpl(mockRemoteDataSource);
  });

  const tProductId = 'prod_987';
  const tErrorMessage = 'Network error, please check connection';
  final tAddToCartRequest = AddToCartRequest(
    productId: tProductId,
    quantity: 2,
  );
  final tUpdateCartQuantityRequest = UpdateCartQuantityRequest(quantity: 4);

  group('addItemToCart', () {
    test(
      'should return SuccessBaseResponse containing mapped domain entity when remote data source succeeds',
      () async {
        // Arrange
        when(mockRemoteDataSource.addItemToCart(any)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseDto>(data: tEmptyCartResponseDto),
        );

        // Act
        final result = await repository.addItemToCart(tAddToCartRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());
        // By using a real DTO, we can test that the mapper (.toDomain) worked correctly
        expect(
          (result as SuccessBaseResponse<CartResponseEntity>)
              .data
              .numOfCartItems,
          equals(0),
        );
        verify(mockRemoteDataSource.addItemToCart(tAddToCartRequest)).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse when remote data source fails to add item',
      () async {
        // Arrange
        when(mockRemoteDataSource.addItemToCart(any)).thenAnswer(
          (_) async =>
              ErrorBaseResponse<CartResponseDto>(errorMessage: tErrorMessage),
        );

        // Act
        final result = await repository.addItemToCart(tAddToCartRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());
        expect(
          (result as ErrorBaseResponse).errorMessage,
          equals(tErrorMessage),
        );
        verify(mockRemoteDataSource.addItemToCart(tAddToCartRequest)).called(1);
      },
    );
  });

  group('getCartItems', () {
    test(
      'should return SuccessBaseResponse with empty cart items list when cart is empty',
      () async {
        // Arrange
        when(mockRemoteDataSource.getCartItems()).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseDto>(data: tEmptyCartResponseDto),
        );

        // Act
        final result = await repository.getCartItems();

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());
        final domainEntity =
            (result as SuccessBaseResponse<CartResponseEntity>).data;
        expect(domainEntity.numOfCartItems, equals(0));
        expect(domainEntity.cart?.cartItems?.isEmpty, isTrue);
        verify(mockRemoteDataSource.getCartItems()).called(1);
      },
    );

    test(
      'should return SuccessBaseResponse with one cart item when cart has single item',
      () async {
        // Arrange
        final singleItemCartDto = CartResponseDto(
          numOfCartItems: 1,
          cart: CartDto(
            cartItems: [CartItemDto(quantity: 1, product: ProductDTO(id: '1'))],
          ),
        );

        when(mockRemoteDataSource.getCartItems()).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseDto>(data: singleItemCartDto),
        );

        // Act
        final result = await repository.getCartItems();

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());
        final domainEntity =
            (result as SuccessBaseResponse<CartResponseEntity>).data;
        expect(domainEntity.numOfCartItems, equals(1));
        expect(domainEntity.cart?.cartItems?.length, equals(1));
        verify(mockRemoteDataSource.getCartItems()).called(1);
      },
    );

    test(
      'should return SuccessBaseResponse with multiple items when cart has several items',
      () async {
        // Arrange
        final multipleItemsCartDto = CartResponseDto(
          numOfCartItems: 2,
          cart: CartDto(
            cartItems: [
              CartItemDto(quantity: 1, product: ProductDTO(id: '1')),
              CartItemDto(quantity: 4, product: ProductDTO(id: '1')),
            ],
          ),
        );

        when(mockRemoteDataSource.getCartItems()).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseDto>(data: multipleItemsCartDto),
        );

        // Act
        final result = await repository.getCartItems();

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());
        final domainEntity =
            (result as SuccessBaseResponse<CartResponseEntity>).data;
        expect(domainEntity.numOfCartItems, equals(2));
        expect(domainEntity.cart?.cartItems?.length, equals(2));
        verify(mockRemoteDataSource.getCartItems()).called(1);
      },
    );

    test(
      'should pass through ErrorBaseResponse information when fetching items fails',
      () async {
        // Arrange
        when(mockRemoteDataSource.getCartItems()).thenAnswer(
          (_) async =>
              ErrorBaseResponse<CartResponseDto>(errorMessage: tErrorMessage),
        );

        // Act
        final result = await repository.getCartItems();

        // Assert
        expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());
        expect(
          (result as ErrorBaseResponse).errorMessage,
          equals(tErrorMessage),
        );
        verify(mockRemoteDataSource.getCartItems()).called(1);
      },
    );
  });

  group('removeItemFromCart', () {
    test(
      'should map to SuccessBaseResponse with Domain entity when deletion on remote source succeeds',
      () async {
        // Arrange
        when(mockRemoteDataSource.removeItemFromCart(any)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseDto>(data: tEmptyCartResponseDto),
        );

        // Act
        final result = await repository.removeItemFromCart(tProductId);

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());
        verify(mockRemoteDataSource.removeItemFromCart(tProductId)).called(1);
      },
    );

    test(
      'should propagate ErrorBaseResponse details when item removal encounters a problem',
      () async {
        // Arrange
        when(mockRemoteDataSource.removeItemFromCart(any)).thenAnswer(
          (_) async =>
              ErrorBaseResponse<CartResponseDto>(errorMessage: tErrorMessage),
        );

        // Act
        final result = await repository.removeItemFromCart(tProductId);

        // Assert
        expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());
        expect(
          (result as ErrorBaseResponse).errorMessage,
          equals(tErrorMessage),
        );
        verify(mockRemoteDataSource.removeItemFromCart(tProductId)).called(1);
      },
    );
  });

  group('updateCartItemQuantity', () {
    test(
      'should issue network update request and return mapped Entity on success status',
      () async {
        // Arrange
        when(mockRemoteDataSource.updateCartItemQuantity(any, any)).thenAnswer(
          (_) async =>
              SuccessBaseResponse<CartResponseDto>(data: tEmptyCartResponseDto),
        );

        // Act
        final result = await repository.updateCartItemQuantity(
          tProductId,
          tUpdateCartQuantityRequest,
        );

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseEntity>>());
        verify(
          mockRemoteDataSource.updateCartItemQuantity(
            tProductId,
            argThat(isA<UpdateCartQuantityRequest>()),
          ),
        ).called(1);
      },
    );

    test(
      'should capture and yield back ErrorBaseResponse text when network update falls short',
      () async {
        // Arrange
        when(mockRemoteDataSource.updateCartItemQuantity(any, any)).thenAnswer(
          (_) async =>
              ErrorBaseResponse<CartResponseDto>(errorMessage: tErrorMessage),
        );

        // Act
        final result = await repository.updateCartItemQuantity(
          tProductId,
          tUpdateCartQuantityRequest,
        );

        // Assert
        expect(result, isA<ErrorBaseResponse<CartResponseEntity>>());
        expect(
          (result as ErrorBaseResponse).errorMessage,
          equals(tErrorMessage),
        );
        verify(
          mockRemoteDataSource.updateCartItemQuantity(
            tProductId,
            argThat(isA<UpdateCartQuantityRequest>()),
          ),
        ).called(1);
      },
    );
  });
}
