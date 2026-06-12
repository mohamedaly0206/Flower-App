import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/data/models/request/shipping_address_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/response/cash/cash_checkout_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/response/credit_card/credit_card_response_entity.dart';
import 'package:flower_app/features/checkout/domain/use_cases/cash_checkout_cash_use_case.dart';
import 'package:flower_app/features/checkout/domain/use_cases/credit_card_checkout_use_case.dart';
import 'package:flower_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flower_app/features/checkout/presentation/view_model/intent/checkout_intent.dart';
import 'package:flower_app/features/checkout/presentation/view_model/state/checkout_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_cubit_test.mocks.dart';

@GenerateMocks([CheckoutCashUseCase, CreditCardCheckoutUseCase])
void main() {
  late MockCheckoutCashUseCase mockCashUseCase;
  late MockCreditCardCheckoutUseCase mockCreditCardUseCase;

  final tCashResponseEntity = CashCheckoutResponseEntity();
  final tCreditCardResponseEntity = CreditCardCheckoutResponseEntity();
  const tErrorMessage = 'Transaction failed. Please try again.';
  final ShippingAddress shippingAddress = ShippingAddress(
    street: '123 Main St',
    phone: '1234567890',
    city: 'New York',
    lat: "40.7128",
    long: "-74.0060",
  );
  final tCheckoutRequest = CheckoutRequest(shippingAddress: shippingAddress);

  setUpAll(() {
    provideDummy<BaseResponse<CashCheckoutResponseEntity>>(
      SuccessBaseResponse<CashCheckoutResponseEntity>(
        data: tCashResponseEntity,
      ),
    );
    provideDummy<BaseResponse<CreditCardCheckoutResponseEntity>>(
      SuccessBaseResponse<CreditCardCheckoutResponseEntity>(
        data: tCreditCardResponseEntity,
      ),
    );
  });

  setUp(() {
    mockCashUseCase = MockCheckoutCashUseCase();
    mockCreditCardUseCase = MockCreditCardCheckoutUseCase();
  });

  group('CheckoutCubit - Intent Validations', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits state with new address when SelectDeliveryAddressIntent is handled',
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      act: (cubit) => cubit.handleCheckoutIntent(
        SelectDeliveryAddressIntent(addressId: 'addr_1'),
      ),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.selectedAddressId,
          'selectedAddressId',
          'addr_1',
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits state with new payment method when SelectPaymentMethodIntent is handled',
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      act: (cubit) => cubit.handleCheckoutIntent(
        SelectPaymentMethodIntent(paymentMethod: PaymentMethod.creditCard),
      ),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.selectedPaymentMethod,
          'selectedPaymentMethod',
          PaymentMethod.creditCard,
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'ignores cash payment selection if order is marked as a gift',
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      seed: () => const CheckoutState(
        isGift: true,
        selectedPaymentMethod: PaymentMethod.creditCard,
      ),
      act: (cubit) => cubit.handleCheckoutIntent(
        SelectPaymentMethodIntent(paymentMethod: PaymentMethod.cashOnDelivery),
      ),
      expect: () => [], // Should emit nothing because of the early return
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits state toggling isGift and auto-assigns correct payment method (true -> credit card)',
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      seed: () => const CheckoutState(isGift: false),
      act: (cubit) => cubit.handleCheckoutIntent(
        SelectIsItGiftIntent(isGift: true),
      ), // The bool param in intent is overridden by !state.isGift in your logic, but passing it anyway to match schema
      expect: () => [
        isA<CheckoutState>().having((s) => s.isGift, 'isGift', true),
        isA<CheckoutState>()
            .having((s) => s.isGift, 'isGift', true)
            .having(
              (s) => s.selectedPaymentMethod,
              'selectedPaymentMethod',
              PaymentMethod.creditCard,
            ),
      ],
    );
  });

  group('CheckoutCubit - PlaceCashOrder', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits [loading, success] when PlaceCashOrderIntent is successful',
      setUp: () {
        when(mockCashUseCase.call(any)).thenAnswer(
          (_) async => SuccessBaseResponse<CashCheckoutResponseEntity>(
            data: tCashResponseEntity,
          ),
        );
      },
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      act: (cubit) => cubit.handleCheckoutIntent(
        PlaceCashOrderIntent(checkoutRequest: tCheckoutRequest),
      ),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.checkoutCashState.isLoading,
          'isLoading',
          true,
        ),
        isA<CheckoutState>().having(
          (s) => s.checkoutCashState.data,
          'data',
          tCashResponseEntity,
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits [loading, error] when PlaceCashOrderIntent fails',
      setUp: () {
        when(mockCashUseCase.call(any)).thenAnswer(
          (_) async => ErrorBaseResponse<CashCheckoutResponseEntity>(
            errorMessage: tErrorMessage,
          ),
        );
      },
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      act: (cubit) => cubit.handleCheckoutIntent(
        PlaceCashOrderIntent(checkoutRequest: tCheckoutRequest),
      ),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.checkoutCashState.isLoading,
          'isLoading',
          true,
        ),
        isA<CheckoutState>().having(
          (s) => s.checkoutCashState.errorMessage,
          'errorMessage',
          tErrorMessage,
        ),
      ],
    );
  });

  group('CheckoutCubit - PlaceCreditCardOrder', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'emits [loading, success] when PlaceCreditCardOrderIntent is successful',
      setUp: () {
        when(mockCreditCardUseCase.call(any, any)).thenAnswer(
          (_) async => SuccessBaseResponse<CreditCardCheckoutResponseEntity>(
            data: tCreditCardResponseEntity,
          ),
        );
      },
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      act: (cubit) => cubit.handleCheckoutIntent(
        PlaceCreditCardOrderIntent(checkoutRequest: tCheckoutRequest),
      ),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.checkoutCreditState.isLoading,
          'isLoading',
          true,
        ),
        isA<CheckoutState>().having(
          (s) => s.checkoutCreditState.data,
          'data',
          tCreditCardResponseEntity,
        ),
      ],
    );

    blocTest<CheckoutCubit, CheckoutState>(
      'emits [loading, error] when PlaceCreditCardOrderIntent fails',
      setUp: () {
        when(mockCreditCardUseCase.call(any, any)).thenAnswer(
          (_) async => ErrorBaseResponse<CreditCardCheckoutResponseEntity>(
            errorMessage: tErrorMessage,
          ),
        );
      },
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      act: (cubit) => cubit.handleCheckoutIntent(
        PlaceCreditCardOrderIntent(checkoutRequest: tCheckoutRequest),
      ),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.checkoutCreditState.isLoading,
          'isLoading',
          true,
        ),
        isA<CheckoutState>().having(
          (s) => s.checkoutCreditState.errorMessage,
          'errorMessage',
          tErrorMessage,
        ),
      ],
    );
  });

  group('CheckoutCubit - ResetCreditState', () {
    blocTest<CheckoutCubit, CheckoutState>(
      'resets checkoutCreditState to a base state when ResetCreditStateIntent is handled',
      build: () => CheckoutCubit(mockCashUseCase, mockCreditCardUseCase),
      seed: () => CheckoutState(
        checkoutCreditState: BaseState<CreditCardCheckoutResponseEntity>(
          data: tCreditCardResponseEntity,
        ),
      ),
      act: (cubit) => cubit.handleCheckoutIntent(ResetCreditStateIntent()),
      expect: () => [
        isA<CheckoutState>().having(
          (s) => s.checkoutCreditState.data,
          'data',
          isNull,
        ),
      ],
    );
  });
}
