import 'package:latlong2/latlong.dart';
import '../../../domain/models/order_location_entity.dart';

abstract class TrackerOrderState {}

class TrackerOrderInitialState extends TrackerOrderState {}

class TrackerOrderLoadingState extends TrackerOrderState {}

class TrackerOrderSuccessState extends TrackerOrderState {
  final OrderLocationEntity locationEntity;
  final List<LatLng> routePoints;

  TrackerOrderSuccessState({
    required this.locationEntity,
    required this.routePoints,
  });
}

class TrackerOrderErrorState extends TrackerOrderState {
  final String errorMessage;

  TrackerOrderErrorState(this.errorMessage);
}
