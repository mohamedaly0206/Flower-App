import 'package:equatable/equatable.dart';

sealed class UserAddressesIntent extends Equatable {
  const UserAddressesIntent();

  @override
  List<Object?> get props => [];
}

class FetchAddressesIntent extends UserAddressesIntent {
  const FetchAddressesIntent();
}

class LoadEgyptLocationsIntent extends UserAddressesIntent {
  const LoadEgyptLocationsIntent();
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

class UpdateGovernorateIntent extends UserAddressesIntent {
  final String governorateId;
  final String governorateName;

  const UpdateGovernorateIntent({
    required this.governorateId,
    required this.governorateName,
  });

  @override
  List<Object?> get props => [governorateId, governorateName];
}

class UpdateCityIntent extends UserAddressesIntent {
  final String cityId;
  final String city;

  const UpdateCityIntent({required this.cityId, required this.city});

  @override
  List<Object?> get props => [cityId, city];
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

class RequestCurrentLocationIntent extends UserAddressesIntent {
  const RequestCurrentLocationIntent();
}
