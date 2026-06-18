import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flower_app/features/checkout/api/data_sources/checkout_remote_data_source_impl.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/data/models/request/shipping_address_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/cash/cash_checkout_response_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card/credit_card_checkout_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CheckoutApiClient])
import 'checkout_remote_data_source_impl_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late CheckoutRemoteDataSourceImpl dataSource;
  late MockCheckoutApiClient mockApiClient;

  setUpAll(() {
    provideDummy<BaseResponse<CashCheckoutResponseDto>>(
      SuccessBaseResponse<CashCheckoutResponseDto>(
        data: CashCheckoutResponseDto(),
      ),
    );
    provideDummy<BaseResponse<CreditCardCheckoutResponseDto>>(
      SuccessBaseResponse<CreditCardCheckoutResponseDto>(
        data: CreditCardCheckoutResponseDto(),
      ),
    );
  });

  setUp(() {
    mockApiClient = MockCheckoutApiClient();
    dataSource = CheckoutRemoteDataSourceImpl(mockApiClient);
  });
  final ShippingAddress shippingAddress = ShippingAddress(
    street: '123 Main St',
    phone: '1234567890',
    city: 'New York',
    lat: "40.7128",
    long: "-74.0060",
  );

  final tCheckoutRequest = CheckoutRequest(shippingAddress: shippingAddress);
  const tStripeUrl = 'https://checkout.stripe.com/pay/test_session';
  final tCashResponseDto = CashCheckoutResponseDto();
  final tCreditCardResponseDto = CreditCardCheckoutResponseDto();

  group('checkoutCashOrder', () {
    test(
      'should return SuccessBaseResponse when the API call is successful',
      () async {
        // Arrange
        when(
          mockApiClient.checkoutCashOrder(any),
        ).thenAnswer((_) async => tCashResponseDto);

        // Act
        final result = await dataSource.checkoutCashOrder(tCheckoutRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<CashCheckoutResponseDto>>());
        expect((result as SuccessBaseResponse).data, equals(tCashResponseDto));
        verify(mockApiClient.checkoutCashOrder(tCheckoutRequest)).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse when the API call throws an Exception',
      () async {
        // Arrange
        when(
          mockApiClient.checkoutCashOrder(any),
        ).thenThrow(Exception('Server configuration error'));

        // Act
        final result = await dataSource.checkoutCashOrder(tCheckoutRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<CashCheckoutResponseDto>>());
        verify(mockApiClient.checkoutCashOrder(tCheckoutRequest)).called(1);
      },
    );
  });

  group('checkoutCreditCardOrder', () {
    test(
      'should return SuccessBaseResponse when the API call is successful',
      () async {
        // Arrange
        when(
          mockApiClient.checkoutCreditCardOrder(any, any),
        ).thenAnswer((_) async => tCreditCardResponseDto);

        // Act
        final result = await dataSource.checkoutCreditCardOrder(
          tStripeUrl,
          tCheckoutRequest,
        );

        // Assert
        expect(
          result,
          isA<SuccessBaseResponse<CreditCardCheckoutResponseDto>>(),
        );
        expect(
          (result as SuccessBaseResponse).data,
          equals(tCreditCardResponseDto),
        );
        verify(
          mockApiClient.checkoutCreditCardOrder(tStripeUrl, tCheckoutRequest),
        ).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse when the API call throws an Exception',
      () async {
        // Arrange
        when(
          mockApiClient.checkoutCreditCardOrder(any, any),
        ).thenThrow(Exception('Payment gateway timeout'));

        // Act
        final result = await dataSource.checkoutCreditCardOrder(
          tStripeUrl,
          tCheckoutRequest,
        );

        // Assert
        expect(result, isA<ErrorBaseResponse<CreditCardCheckoutResponseDto>>());
        verify(
          mockApiClient.checkoutCreditCardOrder(tStripeUrl, tCheckoutRequest),
        ).called(1);
      },
    );
  });
}
