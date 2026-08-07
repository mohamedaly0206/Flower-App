import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tracking_order/domain/entities/tracking_order_entity.dart';
import 'package:flower_app/features/tracking_order/domain/repositories/tracking_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackOrderUseCase {
  final TrackingOrderRepo _repo;

  TrackOrderUseCase(this._repo);

  Stream<BaseResponse<TrackingOrderEntity>> call(String orderId) {
    return _repo.trackOrder(orderId);
  }
}
