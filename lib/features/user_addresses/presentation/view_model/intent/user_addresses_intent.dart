import 'package:equatable/equatable.dart';

sealed class UserAddressesIntent extends Equatable {
  const UserAddressesIntent();

  @override
  List<Object?> get props => [];
}

class FetchAddressesIntent extends UserAddressesIntent {
  const FetchAddressesIntent();
}

class DeleteAddressIntent extends UserAddressesIntent {
  final String id;

  const DeleteAddressIntent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddAddressIntent extends UserAddressesIntent {
  const AddAddressIntent();
}

class UpdateAddressIntent extends UserAddressesIntent {
  const UpdateAddressIntent();
}

class UpdateUsernameIntent extends UserAddressesIntent {
  final String username;

  const UpdateUsernameIntent(this.username);

  @override
  List<Object?> get props => [username];
}

class UpdatePhoneIntent extends UserAddressesIntent {
  final String phone;

  const UpdatePhoneIntent(this.phone);

  @override
  List<Object?> get props => [phone];
}

class UpdateCityIntent extends UserAddressesIntent {
  final String city;

  const UpdateCityIntent(this.city);

  @override
  List<Object?> get props => [city];
}

class UpdateStreetIntent extends UserAddressesIntent {
  final String street;

  const UpdateStreetIntent(this.street);

  @override
  List<Object?> get props => [street];
}

class UpdateLocationIntent extends UserAddressesIntent {
  final String lat;
  final String long;

  const UpdateLocationIntent({required this.lat, required this.long});

  @override
  List<Object?> get props => [lat, long];
}
