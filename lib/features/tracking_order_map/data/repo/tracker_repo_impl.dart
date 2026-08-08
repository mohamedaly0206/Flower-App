import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/models/order_location_entity.dart';
import '../../domain/repo/tracker_repo_contract.dart';
import '../data_sources/tracker_remote_data_source_contract.dart';

@Injectable(as: TrackerRepoContract)
class TrackerRepoImpl implements TrackerRepoContract {
  final TrackerRemoteDataSourceContract _remoteDataSource;

  TrackerRepoImpl(this._remoteDataSource);

  @override
  Future<OrderLocationEntity> getOrderTracking(String orderId) async {
    await _remoteDataSource.getOrderTracking(orderId);

    return const OrderLocationEntity(
      storeLocation: LatLng(30.0444, 31.2357),
      driverLocation: LatLng(30.0480, 31.2390),
      userLocation: LatLng(30.0520, 31.2420),
    );
  }
}
