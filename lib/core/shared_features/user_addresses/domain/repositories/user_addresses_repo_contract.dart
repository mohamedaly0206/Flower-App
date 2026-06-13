import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/entities/user_addresses_body.dart';

abstract class UserAddressesRepoContract {
  Future<BaseResponse<UserAddressesEntity>> getUserAddresses();
  Future<BaseResponse<void>> deleteAddress(String id);
  Future<BaseResponse<void>> addAddress(UserAddressesBody body);
  Future<BaseResponse<void>> updateAddress(String id, UserAddressesBody body);
}
