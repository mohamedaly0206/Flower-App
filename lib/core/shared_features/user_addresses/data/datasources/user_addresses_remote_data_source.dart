import 'package:flower_app/core/shared_features/user_addresses/data/models/responses/user_addresses_dto.dart';

abstract interface class UserAddressesRemoteDataSource {
  Future<UserAddressesDto> getUserAddresses();

  Future<void> deleteAddress(String id);

  Future<void> addAddress(Map<String, dynamic> body);

  Future<void> updateAddress(String id, Map<String, dynamic> body);
}
