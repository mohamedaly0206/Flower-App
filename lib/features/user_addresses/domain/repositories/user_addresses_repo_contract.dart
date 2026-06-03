import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/user_addresses/domain/entities/user_addresses_entity.dart';

abstract class UserAddressesRepoContract {
  Future<BaseResponse<UserAddressesEntity>> getUserAddresses();
  Future<BaseResponse<void>> deleteAddress(String id);
}
