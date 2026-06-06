import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/data/models/response/cash/cash_checkout_response_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card/credit_card_checkout_response_dto.dart';

abstract interface class CheckoutRemoteDataSourceContract {
  final CheckoutApiClient apiClient;
  CheckoutRemoteDataSourceContract(this.apiClient);
  Future<BaseResponse<CashCheckoutResponseDto>> checkoutCashOrder(
    CheckoutRequest checkoutRequest,
  );
  Future<BaseResponse<CreditCardCheckoutResponseDto>> checkoutCreditCardOrder(
    String url,
    CheckoutRequest checkoutRequest,
  );
}
