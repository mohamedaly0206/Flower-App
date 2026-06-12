import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/data/models/request/shipping_address_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/cash/cash_checkout_response_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card/credit_card_checkout_response_dto.dart';
import 'package:flower_app/features/checkout/data/repositories/checkout_repo_impl.dart';
import 'package:flower_app/features/checkout/domain/entities/response/cash/cash_checkout_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/response/credit_card/credit_card_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CheckoutRemoteDataSourceContract])
import 'checkout_repo_impl_test.mocks.dart';

void main() {
  late CheckoutRepoImpl repository;
  late MockCheckoutRemoteDataSourceContract mockRemoteDataSource;

  final tCashResponseDto = CashCheckoutResponseDto();
  final tCreditCardResponseDto = CreditCardCheckoutResponseDto();

  setUpAll(() {
    provideDummy<BaseResponse<CashCheckoutResponseDto>>(
      SuccessBaseResponse<CashCheckoutResponseDto>(data: tCashResponseDto),
    );
    provideDummy<BaseResponse<CreditCardCheckoutResponseDto>>(
      SuccessBaseResponse<CreditCardCheckoutResponseDto>(data: tCreditCardResponseDto),
    );
  });

  setUp(() {
    mockRemoteDataSource = MockCheckoutRemoteDataSourceContract();
    repository = CheckoutRepoImpl(mockRemoteDataSource);
  });
final ShippingAddress shippingAddress = ShippingAddress(
    street: '123 Main St',
    phone: '1234567890',
    city: 'New York',
    lat: "40.7128",
    long: "-74.0060",
  );

  final tCheckoutRequest = CheckoutRequest(
    shippingAddress: shippingAddress
  );
  const tStripeUrl = 'https://checkout.stripe.com/pay/test_session';
  const tErrorMessage = 'Connection lost';

  group('checkoutCashOrder', () {
    test(
      'should return SuccessBaseResponse mapped to Domain Entity when data source is successful',
      () async {
        // Arrange
        when(mockRemoteDataSource.checkoutCashOrder(any)).thenAnswer(
          (_) async => SuccessBaseResponse<CashCheckoutResponseDto>(data: tCashResponseDto),
        );

        // Act
        final result = await repository.checkoutCashOrder(tCheckoutRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<CashCheckoutResponseEntity>>());
        verify(mockRemoteDataSource.checkoutCashOrder(tCheckoutRequest)).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse when data source fails',
      () async {
        // Arrange
        when(mockRemoteDataSource.checkoutCashOrder(any)).thenAnswer(
          (_) async => ErrorBaseResponse<CashCheckoutResponseDto>(errorMessage: tErrorMessage),
        );

        // Act
        final result = await repository.checkoutCashOrder(tCheckoutRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<CashCheckoutResponseEntity>>());
        expect((result as ErrorBaseResponse).errorMessage, equals(tErrorMessage));
        verify(mockRemoteDataSource.checkoutCashOrder(tCheckoutRequest)).called(1);
      },
    );
  });

  group('checkoutCreditCardOrder', () {
    test(
      'should return SuccessBaseResponse mapped to Domain Entity when data source is successful',
      () async {
        // Arrange
        when(mockRemoteDataSource.checkoutCreditCardOrder(any, any)).thenAnswer(
          (_) async => SuccessBaseResponse<CreditCardCheckoutResponseDto>(data: tCreditCardResponseDto),
        );

        // Act
        final result = await repository.checkoutCreditCardOrder(tStripeUrl, tCheckoutRequest);

        // Assert
        expect(result, isA<SuccessBaseResponse<CreditCardCheckoutResponseEntity>>());
        verify(mockRemoteDataSource.checkoutCreditCardOrder(tStripeUrl, tCheckoutRequest)).called(1);
      },
    );

    test(
      'should return ErrorBaseResponse when data source fails',
      () async {
        // Arrange
        when(mockRemoteDataSource.checkoutCreditCardOrder(any, any)).thenAnswer(
          (_) async => ErrorBaseResponse<CreditCardCheckoutResponseDto>(errorMessage: tErrorMessage),
        );

        // Act
        final result = await repository.checkoutCreditCardOrder(tStripeUrl, tCheckoutRequest);

        // Assert
        expect(result, isA<ErrorBaseResponse<CreditCardCheckoutResponseEntity>>());
        expect((result as ErrorBaseResponse).errorMessage, equals(tErrorMessage));
        verify(mockRemoteDataSource.checkoutCreditCardOrder(tStripeUrl, tCheckoutRequest)).called(1);
      },
    );
  });
}