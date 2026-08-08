import 'package:dio/dio.dart';
import 'package:flower_app/features/tracker_order/data/models/order_tracking_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/values/api_endpoints.dart';

part 'tracker_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class TrackerApiClient {
  @factoryMethod
  factory TrackerApiClient(Dio dio) = _TrackerApiClient;

  @GET(ApiEndpoints.orders)
  Future<OrderTrackingResponseDto> getOrderTracking(@Path('id') String orderId);
}