import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';
import 'package:flower_app/features/orders/domain/repo/orders_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersRepoUseCase {
  final OrdersRepoContract _ordersRepoContract;

  OrdersRepoUseCase(this._ordersRepoContract);
  Future<BaseResponse<List<OrdersModel>>> call() async {
    return await _ordersRepoContract.getUserOrders();
  }
}
