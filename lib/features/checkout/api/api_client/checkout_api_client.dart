import 'package:dio/dio.dart';
import 'package:flower_app/core/values/api_endpoints.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/data/models/response/checkout_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'checkout_api_client.g.dart';

@injectable
@RestApi()
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio) => _CheckoutApiClient(dio);

  @POST(ApiEndpoints.orders)
  Future<CheckoutResponseDto> checkoutCashOrder(
    @Body() CheckoutRequest checkoutRequest,
  );
}
