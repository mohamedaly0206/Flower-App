import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import '../../../domain/use_case/get_order_tracking_use_case.dart';
import '../state/tracker_order_state.dart';

@injectable
class TrackerOrderCubit extends Cubit<TrackerOrderState> {
  final GetOrderTrackingUseCase _getOrderTrackingUseCase;

  TrackerOrderCubit(this._getOrderTrackingUseCase)
    : super(TrackerOrderInitialState());

  Future<void> loadOrderTracking(String orderId) async {
    emit(TrackerOrderLoadingState());
    try {
      final locationEntity = await _getOrderTrackingUseCase(orderId);
      final routePoints = await _fetchOSRMRoute(
        locationEntity.storeLocation,
        locationEntity.userLocation,
      );

      emit(
        TrackerOrderSuccessState(
          locationEntity: locationEntity,
          routePoints: routePoints,
        ),
      );
    } catch (e) {
      emit(TrackerOrderErrorState(e.toString()));
    }
  }

  Future<List<LatLng>> _fetchOSRMRoute(LatLng start, LatLng end) async {
    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${start.longitude},${start.latitude};${end.longitude},${end.latitude}'
      '?overview=full&geometries=geojson',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates =
          data['routes'][0]['geometry']['coordinates'];

      return coordinates
          .map((point) => LatLng(point[1].toDouble(), point[0].toDouble()))
          .toList();
    }
    return [];
  }
}
