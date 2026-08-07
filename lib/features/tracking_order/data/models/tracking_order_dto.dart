import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/features/tracking_order/domain/entities/tracking_order_entity.dart';

class TrackingOrderDto {
  final String orderId;
  final String? driverId;
  final String? driverName;
  final String? driverPhone;
  final String status;
  final DateTime? updatedAt;
  final DateTime? acceptedAt;

  const TrackingOrderDto({
    required this.orderId,
    this.driverId,
    this.driverName,
    this.driverPhone,
    required this.status,
    this.updatedAt,
    this.acceptedAt,
  });

  factory TrackingOrderDto.fromJson(Map<String, dynamic> json, String id) {
    final userMap = json['user'] as Map<String, dynamic>?;

    final status =
        json['status'] as String? ??
        userMap?['status'] as String? ??
        json['state'] as String? ??
        'inProgress';

    return TrackingOrderDto(
      orderId: id,
      driverId: json['driverId'] as String?,
      driverName: json['driverName'] as String?,
      driverPhone: json['driverPhone'] as String?,
      status: status,
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
      acceptedAt: (json['acceptedAt'] as Timestamp?)?.toDate(),
    );
  }

  TrackingOrderEntity toDomain() {
    return TrackingOrderEntity(
      orderId: orderId,
      driverId: driverId,
      driverName: driverName,
      driverPhone: driverPhone,
      status: status,
      updatedAt: updatedAt,
      acceptedAt: acceptedAt,
    );
  }
}
