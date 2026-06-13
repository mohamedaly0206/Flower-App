class UserAddressesBody {
  final String street;
  final String phone;
  final String city;
  final String username;
  final String lat;
  final String long;

  const UserAddressesBody({
    required this.street,
    required this.phone,
    required this.city,
    required this.username,
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'phone': phone,
      'city': city,
      'username': username,
      'lat': lat,
      'long': long,
    };
  }
}
