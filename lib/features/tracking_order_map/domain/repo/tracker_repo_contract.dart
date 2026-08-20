import '../models/order_location_entity.dart';

abstract class TrackerRepoContract {
  Future<OrderLocationEntity> getOrderTracking(String orderId);
}