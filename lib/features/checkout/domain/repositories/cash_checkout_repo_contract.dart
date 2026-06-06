import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/domain/entities/response/cash/cash_checkout_response_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/response/credit_card/credit_card_response_entity.dart';

abstract interface class CheckoutRepoContract {
  Future<BaseResponse<CashCheckoutResponseEntity>> checkoutCashOrder(
    CheckoutRequest checkoutRequest,
  );
  Future<BaseResponse<CreditCardCheckoutResponseEntity>>
  checkoutCreditCardOrder(String url, CheckoutRequest checkoutRequest);
}
