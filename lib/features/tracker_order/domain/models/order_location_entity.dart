import 'package:latlong2/latlong.dart';

class OrderLocationEntity {
  final LatLng userLocation;
  final LatLng storeLocation;
  final LatLng driverLocation;

  const OrderLocationEntity({
    required this.userLocation,
    required this.storeLocation,
    required this.driverLocation,
  });
}