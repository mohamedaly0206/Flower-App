import 'package:flower_app/features/user_addresses/data/models/responses/user_addresses_dto.dart';

abstract interface class UserAddressesRemoteDataSource {
  Future<UserAddressesDto> getUserAddresses();

  Future<void> deleteAddress(String id);
}
