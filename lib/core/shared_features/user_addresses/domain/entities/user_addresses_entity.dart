class AddressEntity {
  final String? id;
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;

  AddressEntity({
    this.id,
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  AddressEntity copyWith({
    String? id,
    String? street,
    String? phone,
    String? city,
    String? lat,
    String? long,
    String? username,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      street: street ?? this.street,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      username: username ?? this.username,
    );
  }
}

class UserAddressesEntity {
  final String? message;
  final List<AddressEntity>? addresses;

  UserAddressesEntity({this.message, this.addresses});
}
