import 'package:json_annotation/json_annotation.dart';

part 'order_tracking_response_dto.g.dart';

@JsonSerializable()
class OrderTrackingResponseDto {
  final double? userLat;
  final double? userLng;
  final double? storeLat;
  final double? storeLng;
  final double? driverLat;
  final double? driverLng;

  const OrderTrackingResponseDto({
    this.userLat,
    this.userLng,
    this.storeLat,
    this.storeLng,
    this.driverLat,
    this.driverLng,
  });

  factory OrderTrackingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderTrackingResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderTrackingResponseDtoToJson(this);
}