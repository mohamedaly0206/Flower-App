import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/tracking_order/data/models/tracking_order_dto.dart';

abstract interface class TrackingOrderRemoteDataSource {
  Stream<BaseResponse<TrackingOrderDto>> trackOrder(String orderId);
  Future<BaseResponse<void>> completeOrder(String orderId);
}
