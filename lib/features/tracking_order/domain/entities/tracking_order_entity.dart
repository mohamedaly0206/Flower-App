import 'package:equatable/equatable.dart';

class TrackingOrderEntity extends Equatable {
  final String orderId;
  final String? driverId;
  final String? driverName;
  final String? driverPhone;
  final String status;
  final DateTime? updatedAt;
  final DateTime? acceptedAt;

  const TrackingOrderEntity({
    required this.orderId,
    this.driverId,
    this.driverName,
    this.driverPhone,
    required this.status,
    this.updatedAt,
    this.acceptedAt,
  });

  @override
  List<Object?> get props => [
    orderId,
    driverId,
    driverName,
    driverPhone,
    status,
    updatedAt,
    acceptedAt,
  ];
}
