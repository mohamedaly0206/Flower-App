import 'package:flower_app/features/orders/api/api_client/orders_api_client.dart';
import 'package:flower_app/features/orders/data/data_sources/orders_remote_data_source_contract.dart';
import 'package:flower_app/features/orders/data/models/orders_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final OrdersApiClient _apiClient;

  OrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<OrdersResponseDto> getUserOrders() async {
    return await _apiClient.getUserOrders();
  }
}
