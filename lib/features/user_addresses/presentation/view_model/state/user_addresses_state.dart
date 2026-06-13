import 'package:equatable/equatable.dart';
import 'package:flower_app/features/user_addresses/data/models/local/city_model.dart';
import 'package:flower_app/features/user_addresses/data/models/local/governorate_model.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';

enum UserAddressesStatus { initial, loading, success, error, saving }

class UserAddressesState extends Equatable {
  final UserAddressesStatus status;
  final List<AddressEntity> addresses;
  final AddressEntity? selectedAddress;
  final String username;
  final String phone;
  final String governorateId;
  final String governorateName;
  final String cityId;
  final String city;
  final String street;
  final String lat;
  final String long;
  final List<GovernorateModel> governorates;
  final List<CityModel> allCities;
  final List<CityModel> filteredCities;
  final bool locationsLoaded;
  final String? errorMessage;
  final String? successMessage;

  const UserAddressesState({
    this.status = UserAddressesStatus.initial,
    this.addresses = const [],
    this.selectedAddress,
    this.username = '',
    this.phone = '',
    this.governorateId = '',
    this.governorateName = '',
    this.cityId = '',
    this.city = '',
    this.street = '',
    this.lat = '',
    this.long = '',
    this.governorates = const [],
    this.allCities = const [],
    this.filteredCities = const [],
    this.locationsLoaded = false,
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
    String? governorateId,
    String? governorateName,
    String? cityId,
    String? city,
    String? street,
    String? lat,
    String? long,
    List<GovernorateModel>? governorates,
    List<CityModel>? allCities,
    List<CityModel>? filteredCities,
    bool? locationsLoaded,
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
      governorateId: governorateId ?? this.governorateId,
      governorateName: governorateName ?? this.governorateName,
      cityId: cityId ?? this.cityId,
      city: city ?? this.city,
      street: street ?? this.street,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      governorates: governorates ?? this.governorates,
      allCities: allCities ?? this.allCities,
      filteredCities: filteredCities ?? this.filteredCities,
      locationsLoaded: locationsLoaded ?? this.locationsLoaded,
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
    governorateId,
    governorateName,
    cityId,
    city,
    street,
    lat,
    long,
    governorates,
    allCities,
    filteredCities,
    locationsLoaded,
    errorMessage,
    successMessage,
  ];
}
