import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/orders/data/data_sources/orders_remote_data_source_contract.dart';
import 'package:flower_app/features/orders/domain/models/orders_model.dart';
import 'package:flower_app/features/orders/domain/repo/orders_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepoContract)
class OrdersRepoImpl implements OrdersRepoContract {
  final OrdersRemoteDataSource _remoteDataSource;

  OrdersRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<OrdersModel>>> getUserOrders() async {
    try {
      final response = await _remoteDataSource.getUserOrders();

      final List<OrdersModel> ordersList =
          response.orders?.map((e) => e.toDomain()).toList() ?? [];

      return SuccessBaseResponse<List<OrdersModel>>(data: ordersList);
    } catch (error) {
      return ErrorBaseResponse<List<OrdersModel>>(
        errorMessage: error.toString(),
      );
    }
  }
}
