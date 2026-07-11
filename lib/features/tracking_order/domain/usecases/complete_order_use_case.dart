import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tracking_order/domain/repositories/tracking_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompleteOrderUseCase {
  final TrackingOrderRepo _repo;

  CompleteOrderUseCase(this._repo);

  Future<BaseResponse<void>> call(String orderId) {
    return _repo.completeOrder(orderId);
  }
}
