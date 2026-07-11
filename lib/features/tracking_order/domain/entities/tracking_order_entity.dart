import 'package:equatable/equatable.dart';

class TrackingOrderEntity extends Equatable {
  final String orderId;
  final String? driverId;
  final String? driverName;
  final String? driverPhone;
  final String status;

  const TrackingOrderEntity({
    required this.orderId,
    this.driverId,
    this.driverName,
    this.driverPhone,
    required this.status,
  });

  @override
  List<Object?> get props => [orderId, driverId, driverName, driverPhone, status];
}
