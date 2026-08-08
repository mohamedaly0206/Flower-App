import 'package:injectable/injectable.dart';
import '../../data/data_sources/tracker_remote_data_source_contract.dart';
import '../../data/models/order_tracking_response_dto.dart';
import '../api_client/tracker_api_client.dart';

@Injectable(as: TrackerRemoteDataSourceContract)
class TrackerRemoteDataSourceImpl implements TrackerRemoteDataSourceContract {
  final TrackerApiClient _apiClient;

  TrackerRemoteDataSourceImpl(this._apiClient);

  @override
  Future<OrderTrackingResponseDto> getOrderTracking(String orderId) async {
    return await _apiClient.getOrderTracking(orderId);
  }
}