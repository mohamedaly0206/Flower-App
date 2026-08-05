import '../models/order_tracking_response_dto.dart';

abstract class TrackerRemoteDataSourceContract {
  Future<OrderTrackingResponseDto> getOrderTracking(String orderId);
}