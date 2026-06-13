import 'package:flower_app/core/shared_features/user_addresses/api/api_client/user_addresses_api_client.dart';
import 'package:flower_app/core/shared_features/user_addresses/data/datasources/user_addresses_remote_data_source.dart';
import 'package:flower_app/core/shared_features/user_addresses/data/models/responses/user_addresses_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserAddressesRemoteDataSource)
class UserAddressesRemoteDataSourceImpl
    implements UserAddressesRemoteDataSource {
  final UserAddressesApiClient _apiClient;

  UserAddressesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserAddressesDto> getUserAddresses() {
    return _apiClient.getUserAddresses();
  }

  @override
  Future<void> deleteAddress(String id) {
    return _apiClient.deleteAddress(id);
  }

  @override
  Future<void> addAddress(Map<String, dynamic> body) {
    return _apiClient.addAddress(body);
  }

  @override
  Future<void> updateAddress(String id, Map<String, dynamic> body) {
    return _apiClient.updateAddress(id, body);
  }
}
