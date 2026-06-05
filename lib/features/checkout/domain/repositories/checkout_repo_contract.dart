import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/domain/entities/response/checkout_response_entity.dart';

abstract interface class CheckoutRepoContract {
  Future<BaseResponse<CheckoutResponseEntity>> checkoutCashOrder(
    CheckoutRequest checkoutRequest,
  );
}
