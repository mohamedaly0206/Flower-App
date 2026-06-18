import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/entities/user_addresses_body.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/repositories/user_addresses_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAddressUseCase {
  final UserAddressesRepoContract repository;

  UpdateAddressUseCase(this.repository);

  Future<BaseResponse<void>> call(String id, UserAddressesBody body) {
    return repository.updateAddress(id, body);
  }
}
