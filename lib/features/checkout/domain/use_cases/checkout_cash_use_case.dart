import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/domain/entities/response/checkout_response_entity.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckoutCashUseCase {
  final CheckoutRepoContract _checkoutRepo;
  CheckoutCashUseCase(this._checkoutRepo);
  Future<BaseResponse<CheckoutResponseEntity>> call(CheckoutRequest checkoutRequest) {
    return _checkoutRepo.checkoutCashOrder(checkoutRequest);
  }
}
