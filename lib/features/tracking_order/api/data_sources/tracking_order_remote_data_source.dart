import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/tracking_order/data/data_sources/tracking_order_remote_data_source_contract.dart';
import 'package:flower_app/features/tracking_order/data/models/tracking_order_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackingOrderRemoteDataSource)
class TrackingOrderRemoteDataSourceImpl
    implements TrackingOrderRemoteDataSource {
  TrackingOrderRemoteDataSourceImpl();

  @override
  Stream<BaseResponse<TrackingOrderDto>> trackOrder(String orderId) {
    try {
      return FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .snapshots()
          .map((snapshot) {
            if (!snapshot.exists) {
              return ErrorBaseResponse<TrackingOrderDto>(
                errorMessage: 'Order not found',
              );
            }
            final data = snapshot.data();
            if (data == null) {
              return ErrorBaseResponse<TrackingOrderDto>(
                errorMessage: 'Order data is empty',
              );
            }

            final dto = TrackingOrderDto.fromJson(data, snapshot.id);
            return SuccessBaseResponse<TrackingOrderDto>(data: dto);
          })
          .handleError((e) {
            return ErrorBaseResponse<TrackingOrderDto>(
              errorMessage: ServerFailure.failureHandler(e).errorMessage,
            );
          });
    } catch (e) {
      return Stream.value(
        ErrorBaseResponse<TrackingOrderDto>(
          errorMessage: ServerFailure.failureHandler(e).errorMessage,
        ),
      );
    }
  }

  @override
  Future<BaseResponse<void>> completeOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).update(
        {'status': 'completed', 'state': 'completed'},
      );
      return SuccessBaseResponse<void>(data: null);
    } catch (e) {
      return ErrorBaseResponse<void>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
