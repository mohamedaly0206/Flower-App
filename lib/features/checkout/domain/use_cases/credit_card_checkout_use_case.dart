import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/domain/entities/response/credit_card/credit_card_response_entity.dart';
import 'package:flower_app/features/checkout/domain/repositories/cash_checkout_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreditCardCheckoutUseCase {
  final CheckoutRepoContract _checkoutRepo;
  CreditCardCheckoutUseCase(this._checkoutRepo);
  Future<BaseResponse<CreditCardCheckoutResponseEntity>> call(
    String url,
    CheckoutRequest checkoutRequest,
  ) {
    return _checkoutRepo.checkoutCreditCardOrder(url, checkoutRequest);
  }
}
