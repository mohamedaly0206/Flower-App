import 'package:equatable/equatable.dart';

class ShippingAddressEntity extends Equatable {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  const ShippingAddressEntity({this.street, this.phone, this.city, this.lat, this.long});
  
  @override
  List<Object?> get props => [street, phone, city, lat, long];
}