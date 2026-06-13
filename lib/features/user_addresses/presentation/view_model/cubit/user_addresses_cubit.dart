import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/user_addresses/presentation/utils/address_message_keys.dart';
import 'package:flower_app/features/user_addresses/data/datasources/egypt_locations_local_data_source.dart';
import 'package:flower_app/features/user_addresses/data/models/local/city_model.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_body.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/add_address_use_case.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/delete_address_use_case.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/update_address_use_case.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/user_addresses_use_case.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserAddressesCubit extends Cubit<UserAddressesState> {
  final UserAddressesUseCase _getAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final EgyptLocationsLocalDataSource _locationsDataSource;

  UserAddressesCubit(
    this._getAddressesUseCase,
    this._deleteAddressUseCase,
    this._addAddressUseCase,
    this._updateAddressUseCase,
  ) : _locationsDataSource = EgyptLocationsLocalDataSource(),
      super(const UserAddressesState());

  void handleIntent(UserAddressesIntent intent) {
    switch (intent) {
      case FetchAddressesIntent():
        _fetchAddresses();
      case LoadEgyptLocationsIntent():
        _loadEgyptLocations();
      case DeleteAddressIntent():
        _deleteAddress(intent.id);
      case AddAddressIntent():
        _addAddress();
      case UpdateAddressIntent():
        _updateAddress();
      case UpdateUsernameIntent():
        _updateUsername(intent.username);
      case UpdatePhoneIntent():
        _updatePhone(intent.phone);
      case UpdateGovernorateIntent():
        _updateGovernorate(
          governorateId: intent.governorateId,
          governorateName: intent.governorateName,
        );
      case UpdateCityIntent():
        _updateCitySelection(cityId: intent.cityId, city: intent.city);
      case UpdateStreetIntent():
        _updateStreet(intent.street);
      case UpdateLocationIntent():
        _updateLocation(lat: intent.lat, long: intent.long);
      case RequestCurrentLocationIntent():
        _requestCurrentLocation();
    }
  }

  void prepareAddForm() {
    emit(
      state.copyWith(
        status: UserAddressesStatus.initial,
        clearSelectedAddress: true,
        username: '',
        phone: '',
        governorateId: '',
        governorateName: '',
        cityId: '',
        city: '',
        street: '',
        lat: '',
        long: '',
        filteredCities: const [],
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
  }

  void prepareEditForm(AddressEntity address) {
    emit(
      state.copyWith(
        status: UserAddressesStatus.initial,
        selectedAddress: address,
        username: address.username ?? '',
        phone: address.phone ?? '',
        city: address.city ?? '',
        street: address.street ?? '',
        lat: address.lat ?? '',
        long: address.long ?? '',
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
  }

  Future<void> _loadEgyptLocations() async {
    if (state.locationsLoaded) {
      if (state.city.isNotEmpty) {
        _resolveGovernorateAndCityFromSavedCity(state.city);
      }
      return;
    }

    try {
      final governorates = await _locationsDataSource.loadGovernorates();
      final cities = await _locationsDataSource.loadCities();

      emit(
        state.copyWith(
          governorates: governorates,
          allCities: cities,
          locationsLoaded: true,
          clearErrorMessage: true,
        ),
      );

      if (state.city.isNotEmpty) {
        _resolveGovernorateAndCityFromSavedCity(state.city);
      }
    } catch (_) {
      emit(
        state.copyWith(
          status: UserAddressesStatus.error,
          errorMessage: AddressMessageKeys.failedLoadLocations,
          clearSuccessMessage: true,
        ),
      );
    }
  }

  void _resolveGovernorateAndCityFromSavedCity(String cityName) {
    if (cityName.isEmpty || state.allCities.isEmpty) return;

    CityModel? matchedCity;
    for (final city in state.allCities) {
      if (city.nameEn.toLowerCase() == cityName.toLowerCase() ||
          city.nameAr == cityName) {
        matchedCity = city;
        break;
      }
    }

    if (matchedCity == null) return;

    String governorateName = state.governorateName;
    for (final governorate in state.governorates) {
      if (governorate.id == matchedCity.governorateId) {
        governorateName = governorate.nameEn;
        break;
      }
    }

    final filtered = _locationsDataSource.filterCitiesByGovernorate(
      state.allCities,
      matchedCity.governorateId,
    );

    emit(
      state.copyWith(
        governorateId: matchedCity.governorateId,
        governorateName: governorateName,
        cityId: matchedCity.id,
        city: matchedCity.nameEn,
        filteredCities: filtered,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> _fetchAddresses() async {
    emit(
      state.copyWith(
        status: UserAddressesStatus.loading,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final response = await _getAddressesUseCase();

    switch (response) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.success,
            addresses: response.data.addresses ?? [],
            clearErrorMessage: true,
            clearSuccessMessage: true,
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.error,
            errorMessage: response.errorMessage,
            clearSuccessMessage: true,
          ),
        );
    }
  }

  Future<void> _deleteAddress(String id) async {
    emit(
      state.copyWith(
        status: UserAddressesStatus.loading,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final response = await _deleteAddressUseCase(id);

    switch (response) {
      case SuccessBaseResponse():
        final updatedList = state.addresses.where((e) => e.id != id).toList();
        emit(
          state.copyWith(
            status: UserAddressesStatus.success,
            addresses: updatedList,
            clearErrorMessage: true,
            clearSuccessMessage: true,
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.error,
            errorMessage: response.errorMessage,
            clearSuccessMessage: true,
          ),
        );
    }
  }

  Future<void> _addAddress() async {
    final validationError = _validateForm();
    if (validationError != null) {
      emit(
        state.copyWith(
          status: UserAddressesStatus.error,
          errorMessage: validationError,
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: UserAddressesStatus.saving,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final response = await _addAddressUseCase(_buildBody());

    switch (response) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.success,
            successMessage: AddressMessageKeys.addressSavedSuccessfully,
            clearErrorMessage: true,
            clearSelectedAddress: true,
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.error,
            errorMessage: response.errorMessage,
            clearSuccessMessage: true,
          ),
        );
    }
  }

  Future<void> _updateAddress() async {
    final id = state.selectedAddress?.id;
    if (id == null || id.isEmpty) {
      emit(
        state.copyWith(
          status: UserAddressesStatus.error,
          errorMessage: AddressMessageKeys.addressNotFound,
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    final validationError = _validateForm();
    if (validationError != null) {
      emit(
        state.copyWith(
          status: UserAddressesStatus.error,
          errorMessage: validationError,
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: UserAddressesStatus.saving,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );

    final response = await _updateAddressUseCase(id, _buildBody());

    switch (response) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.success,
            successMessage: AddressMessageKeys.addressUpdatedSuccessfully,
            clearErrorMessage: true,
            clearSelectedAddress: true,
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.error,
            errorMessage: response.errorMessage,
            clearSuccessMessage: true,
          ),
        );
    }
  }

  Future<void> _requestCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(
        state.copyWith(
          status: UserAddressesStatus.error,
          errorMessage: AddressMessageKeys.locationServicesDisabled,
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      emit(
        state.copyWith(
          status: UserAddressesStatus.error,
          errorMessage: AddressMessageKeys.locationPermissionRequired,
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      emit(
        state.copyWith(
          status: UserAddressesStatus.error,
          errorMessage: AddressMessageKeys.locationPermissionDeniedForever,
          clearSuccessMessage: true,
        ),
      );
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      _updateLocation(
        lat: position.latitude.toString(),
        long: position.longitude.toString(),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: UserAddressesStatus.error,
          errorMessage: AddressMessageKeys.failedGetCurrentLocation,
          clearSuccessMessage: true,
        ),
      );
    }
  }

  void _updateUsername(String username) {
    emit(state.copyWith(username: username, clearErrorMessage: true));
  }

  void _updatePhone(String phone) {
    emit(state.copyWith(phone: phone, clearErrorMessage: true));
  }

  void _updateGovernorate({
    required String governorateId,
    required String governorateName,
  }) {
    final filtered = _locationsDataSource.filterCitiesByGovernorate(
      state.allCities,
      governorateId,
    );

    emit(
      state.copyWith(
        governorateId: governorateId,
        governorateName: governorateName,
        cityId: '',
        city: '',
        filteredCities: filtered,
        clearErrorMessage: true,
      ),
    );
  }

  void _updateCitySelection({required String cityId, required String city}) {
    emit(
      state.copyWith(
        cityId: cityId,
        city: city,
        clearErrorMessage: true,
      ),
    );
  }

  void _updateStreet(String street) {
    emit(state.copyWith(street: street, clearErrorMessage: true));
  }

  void _updateLocation({required String lat, required String long}) {
    emit(state.copyWith(lat: lat, long: long, clearErrorMessage: true));
  }

  UserAddressesBody _buildBody() {
    return UserAddressesBody(
      username: state.username.trim(),
      phone: _normalizePhone(state.phone.trim()),
      city: state.city.trim(),
      street: state.street.trim(),
      lat: state.lat,
      long: state.long,
    );
  }

  String _normalizePhone(String phone) {
    if (RegExp(r'^01[0125][0-9]{8}$').hasMatch(phone)) {
      return '+20${phone.substring(1)}';
    }
    return phone;
  }

  String? _validateForm() {
    final username = state.username.trim();
    if (username.isEmpty) {
      return AddressMessageKeys.recipientNameRequired;
    }
    if (username.length < 3) {
      return AddressMessageKeys.nameLength;
    }

    final phone = state.phone.trim();
    if (phone.isEmpty) {
      return AddressMessageKeys.phoneRequired;
    }
    if (!_isValidEgyptianPhone(phone)) {
      return AddressMessageKeys.phoneInvalid;
    }

    if (state.governorateId.isEmpty) {
      return AddressMessageKeys.governorateRequired;
    }

    if (state.cityId.isEmpty || state.city.trim().isEmpty) {
      return AddressMessageKeys.cityRequired;
    }

    final street = state.street.trim();
    if (street.isEmpty) {
      return AddressMessageKeys.streetAddressRequired;
    }
    if (street.length < 5) {
      return AddressMessageKeys.streetAddressMinLength;
    }

    if (state.lat.isEmpty || state.long.isEmpty) {
      return AddressMessageKeys.selectLocationOnMap;
    }

    return null;
  }

  bool _isValidEgyptianPhone(String phone) {
    final normalized = phone.replaceAll(' ', '');
    if (RegExp(r'^\+20(10|11|12|15)[0-9]{8}$').hasMatch(normalized)) {
      return true;
    }
    if (RegExp(r'^01[0125][0-9]{8}$').hasMatch(normalized)) {
      return true;
    }
    return false;
  }
}
