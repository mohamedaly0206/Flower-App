import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/app_sections/cart/api/api_client/cart_api_client.dart';
import 'package:flower_app/features/app_sections/cart/api/data_sources/cart_remote_data_source_impl.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/add_to_cart_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/request/update_cart_item_quantity_request.dart';
import 'package:flower_app/features/app_sections/cart/data/models/response/cart_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CartApiClient])
import 'cart_remote_data_source_impl_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CartRemoteDataSourceImpl dataSource;
  late MockCartApiClient mockApiClient;

  setUpAll(() {
    provideDummy<BaseResponse<CartResponseDto>>(
      SuccessBaseResponse<CartResponseDto>(
        data: CartResponseDto(), 
      ),
    );
  });

  setUp(() {
    mockApiClient = MockCartApiClient();
    dataSource = CartRemoteDataSourceImpl(mockApiClient);
  });

  const tProductId = 'product_id_123';
  final tCartResponseDto = CartResponseDto(); 
  final tAddToCartRequest = AddToCartRequest(productId: tProductId, quantity: 1);
  final tUpdateCartQuantityRequest = UpdateCartQuantityRequest(quantity: 5);
  const tFallbackErrorMessage = 'Something went wrong, please try again later';

  group('addItemToCart - Success State', () {
    test(
      'should return SuccessBaseResponse when the API call is successful',
      () async {
        // Arrange
        when(mockApiClient.addItemToCart(any))
            .thenAnswer((_) async => tCartResponseDto);

        // Act
        final result = await dataSource.addItemToCart(tAddToCartRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseDto>>());
        expect((result as SuccessBaseResponse).data, equals(tCartResponseDto));
        verify(mockApiClient.addItemToCart(tAddToCartRequest)).called(1);
      },
    );
  });

  group('addItemToCart - Failure States', () {
    test(
      'should return ErrorBaseResponse with custom fallback message when API throws an Exception',
      () async {
        // Arrange
        when(mockApiClient.addItemToCart(any))
            .thenThrow(Exception('Server connection failed'));

        // Act
        final result = await dataSource.addItemToCart(tAddToCartRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<CartResponseDto>>());
        final errorResult = result as ErrorBaseResponse<CartResponseDto>;
        expect(errorResult.errorMessage, equals(tFallbackErrorMessage));
      },
    );
  });

  group('getCartItems - Success State', () {
    test(
      'should return SuccessBaseResponse when fetching cart items is successful',
      () async {
        // Arrange
        when(mockApiClient.getCartItems())
            .thenAnswer((_) async => tCartResponseDto);

        // Act
        final result = await dataSource.getCartItems();

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseDto>>());
        expect((result as SuccessBaseResponse).data, equals(tCartResponseDto));
        verify(mockApiClient.getCartItems()).called(1);
      },
    );
  });

  group('getCartItems - Failure States', () {
    test(
      'should return ErrorBaseResponse with custom fallback message when API throws an Exception',
      () async {
        // Arrange
        when(mockApiClient.getCartItems()).thenThrow(Exception('Data corruption'));

        // Act
        final result = await dataSource.getCartItems();

        // Assert
        expect(result, isA<ErrorBaseResponse<CartResponseDto>>());
        final errorResult = result as ErrorBaseResponse<CartResponseDto>;
        expect(errorResult.errorMessage, equals(tFallbackErrorMessage));
      },
    );
  });

  group('removeItemFromCart - Success State', () {
    test(
      'should return SuccessBaseResponse when item is successfully removed from cart',
      () async {
        // Arrange
        when(mockApiClient.removeItemFromCart(any))
            .thenAnswer((_) async => tCartResponseDto);

        // Act
        final result = await dataSource.removeItemFromCart(tProductId);

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseDto>>());
        expect((result as SuccessBaseResponse).data, equals(tCartResponseDto));
        verify(mockApiClient.removeItemFromCart(tProductId)).called(1);
      },
    );
  });

  group('removeItemFromCart - Failure States', () {
    test(
      'should return ErrorBaseResponse with custom fallback message when removal throws an Exception',
      () async {
        // Arrange
        when(mockApiClient.removeItemFromCart(any))
            .thenThrow(Exception('Forbidden action'));

        // Act
        final result = await dataSource.removeItemFromCart(tProductId);

        // Assert
        expect(result, isA<ErrorBaseResponse<CartResponseDto>>());
        final errorResult = result as ErrorBaseResponse<CartResponseDto>;
        expect(errorResult.errorMessage, equals(tFallbackErrorMessage));
      },
    );
  });

  group('updateCartItemQuantity - Success State', () {
    test(
      'should return SuccessBaseResponse when item quantity is successfully updated',
      () async {
        // Arrange
        when(mockApiClient.updateCartItemQuantity(any, any))
            .thenAnswer((_) async => tCartResponseDto);

        // Act
        final result = await dataSource.updateCartItemQuantity(
          tProductId,
          tUpdateCartQuantityRequest,
        );

        // Assert
        expect(result, isA<SuccessBaseResponse<CartResponseDto>>());
        expect((result as SuccessBaseResponse).data, equals(tCartResponseDto));
        verify(mockApiClient.updateCartItemQuantity(
          tProductId,
          argThat(isA<UpdateCartQuantityRequest>()),
        )).called(1);
      },
    );
  });

  group('updateCartItemQuantity - Failure States', () {
    test(
      'should return ErrorBaseResponse when quantity modification fails with an unhandled runtime error',
      () async {
        // Arrange
        when(mockApiClient.updateCartItemQuantity(any, any))
            .thenThrow(ArgumentError('Negative values not allowed'));

        // Act
        final result = await dataSource.updateCartItemQuantity(
          tProductId,
          tUpdateCartQuantityRequest,
        );

        // Assert
        expect(result, isA<ErrorBaseResponse<CartResponseDto>>());
        final errorResult = result as ErrorBaseResponse<CartResponseDto>;
        expect(errorResult.errorMessage, equals(tFallbackErrorMessage));
      },
    );
  });
}