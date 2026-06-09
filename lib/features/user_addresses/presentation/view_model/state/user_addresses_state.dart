import 'package:equatable/equatable.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';

enum UserAddressesStatus { initial, loading, success, error, saving }

class UserAddressesState extends Equatable {
  final UserAddressesStatus status;
  final List<AddressEntity> addresses;
  final AddressEntity? selectedAddress;
  final String username;
  final String phone;
  final String city;
  final String street;
  final String lat;
  final String long;
  final String? errorMessage;
  final String? successMessage;

  const UserAddressesState({
    this.status = UserAddressesStatus.initial,
    this.addresses = const [],
    this.selectedAddress,
    this.username = '',
    this.phone = '',
    this.city = '',
    this.street = '',
    this.lat = '',
    this.long = '',
    this.errorMessage,
    this.successMessage,
  });

  bool get isEditMode => selectedAddress != null;

  UserAddressesState copyWith({
    UserAddressesStatus? status,
    List<AddressEntity>? addresses,
    AddressEntity? selectedAddress,
    bool clearSelectedAddress = false,
    String? username,
    String? phone,
    String? city,
    String? street,
    String? lat,
    String? long,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
  }) {
    return UserAddressesState(
      status: status ?? this.status,
      addresses: addresses ?? this.addresses,
      selectedAddress: clearSelectedAddress
          ? null
          : (selectedAddress ?? this.selectedAddress),
      username: username ?? this.username,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      street: street ?? this.street,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccessMessage
          ? null
          : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [
    status,
    addresses,
    selectedAddress,
    username,
    phone,
    city,
    street,
    lat,
    long,
    errorMessage,
    successMessage,
  ];
}
