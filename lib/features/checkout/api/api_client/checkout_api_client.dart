import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/data/models/response/cash/cash_checkout_response_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/credit_card/credit_card_checkout_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'checkout_api_client.g.dart';

@injectable
@RestApi()
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio) = _CheckoutApiClient;

  @POST(ApiEndpoints.orders)
  Future<CashCheckoutResponseDto> checkoutCashOrder(
    @Body() CheckoutRequest checkoutRequest,
  );
  @POST(ApiEndpoints.creditCardCheckout)
  Future<CreditCardCheckoutResponseDto> checkoutCreditCardOrder(
    @Query('url') String url,
    @Body() CheckoutRequest checkoutRequest,
  );
}
