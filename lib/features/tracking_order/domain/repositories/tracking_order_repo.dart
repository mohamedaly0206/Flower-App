import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tracking_order/domain/entities/tracking_order_entity.dart';

abstract class TrackingOrderRepo {
  Stream<BaseResponse<TrackingOrderEntity>> trackOrder(String orderId);
  Future<BaseResponse<void>> completeOrder(String orderId);
}
