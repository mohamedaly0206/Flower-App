import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';

abstract class OrdersRepoContract {
  Future<BaseResponse<List<OrdersModel>>> getUserOrders();
}
