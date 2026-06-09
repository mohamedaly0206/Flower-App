import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_body.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/add_address_use_case.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/delete_address_use_case.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/update_address_use_case.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/user_addresses_use_case.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserAddressesCubit extends Cubit<UserAddressesState> {
  final UserAddressesUseCase _getAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;

  UserAddressesCubit(
    this._getAddressesUseCase,
    this._deleteAddressUseCase,
    this._addAddressUseCase,
    this._updateAddressUseCase,
  ) : super(const UserAddressesState());

  void handleIntent(UserAddressesIntent intent) {
    switch (intent) {
      case FetchAddressesIntent():
        _fetchAddresses();
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
      case UpdateCityIntent():
        _updateCity(intent.city);
      case UpdateStreetIntent():
        _updateStreet(intent.street);
      case UpdateLocationIntent():
        _updateLocation(lat: intent.lat, long: intent.long);
    }
  }

  void prepareAddForm() {
    emit(
      state.copyWith(
        status: UserAddressesStatus.initial,
        clearSelectedAddress: true,
        username: '',
        phone: '',
        city: '',
        street: '',
        lat: '',
        long: '',
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
            successMessage: 'Address saved successfully',
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
          errorMessage: 'Address not found. Please try again.',
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
            successMessage: 'Address updated successfully',
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

  void _updateUsername(String username) {
    emit(state.copyWith(username: username, clearErrorMessage: true));
  }

  void _updatePhone(String phone) {
    emit(state.copyWith(phone: phone, clearErrorMessage: true));
  }

  void _updateCity(String city) {
    emit(state.copyWith(city: city, clearErrorMessage: true));
  }

  void _updateStreet(String street) {
    emit(state.copyWith(street: street, clearErrorMessage: true));
  }

  UserAddressesBody _buildBody() {
    return UserAddressesBody(
      username: state.username.trim(),
      phone: state.phone.trim(),
      city: state.city.trim(),
      street: state.street.trim(),
      lat: state.lat,
      long: state.long,
    );
  }

  void _updateLocation({required String lat, required String long}) {
    emit(state.copyWith(lat: lat, long: long, clearErrorMessage: true));
  }

  String? _validateForm() {
    if (state.username.trim().isEmpty) {
      return 'Recipient name is required';
    }
    if (state.phone.trim().isEmpty) {
      return 'Phone number is required';
    }
    if (state.city.trim().isEmpty) {
      return 'City is required';
    }
    if (state.street.trim().isEmpty) {
      return 'Street address is required';
    }
    return null;
  }
}
