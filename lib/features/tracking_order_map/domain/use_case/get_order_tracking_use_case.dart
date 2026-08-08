import 'package:injectable/injectable.dart';
import '../repo/tracker_repo_contract.dart';
import '../models/order_location_entity.dart';

@injectable
class GetOrderTrackingUseCase {
  final TrackerRepoContract _repository;

  GetOrderTrackingUseCase(this._repository);

  Future<OrderLocationEntity> call(String orderId) async {
    return await _repository.getOrderTracking(orderId);
  }
}