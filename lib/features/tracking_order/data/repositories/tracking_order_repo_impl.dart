import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/tracking_order/data/data_sources/tracking_order_remote_data_source_contract.dart';
import 'package:flower_app/features/tracking_order/data/models/tracking_order_dto.dart';
import 'package:flower_app/features/tracking_order/domain/entities/tracking_order_entity.dart';
import 'package:flower_app/features/tracking_order/domain/repositories/tracking_order_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackingOrderRepo)
class TrackingOrderRepoImpl implements TrackingOrderRepo {
  final TrackingOrderRemoteDataSource _remoteDataSource;

  TrackingOrderRepoImpl(this._remoteDataSource);

 @override
Stream<BaseResponse<TrackingOrderEntity>> trackOrder(String orderId) {
  return _remoteDataSource.trackOrder(orderId).map((response) {
    if (response is SuccessBaseResponse<TrackingOrderDto>) {
      try {
        return SuccessBaseResponse<TrackingOrderEntity>(
          data: response.data.toDomain(),
        );
      } catch (e) {
        return ErrorBaseResponse<TrackingOrderEntity>(
          errorMessage: 'Data parsing error: ${e.toString()}',
        );
      }
    } else if (response is ErrorBaseResponse<TrackingOrderDto>) {
      return ErrorBaseResponse<TrackingOrderEntity>(
        errorMessage: response.errorMessage,
      );
    } else {
      return ErrorBaseResponse<TrackingOrderEntity>(
        errorMessage: AppStrings.errorMessage,
      );
    }
  });
}

  @override
  Future<BaseResponse<void>> completeOrder(String orderId) {
    return _remoteDataSource.completeOrder(orderId);
  }
}
