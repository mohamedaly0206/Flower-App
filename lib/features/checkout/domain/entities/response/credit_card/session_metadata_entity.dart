import 'package:equatable/equatable.dart';

class SessionMetadataEntity extends Equatable {
  final String? city;
  final String? lat;
  final String? long;
  final String? phone;
  final String? street;
  const SessionMetadataEntity({
    this.city,
    this.lat,
    this.long,
    this.phone,
    this.street,
  });

  @override
  List<Object?> get props => [city, lat, long, phone, street];
}
