import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/repositories/user_addresses_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAddressUseCase {
  final UserAddressesRepoContract repository;

  DeleteAddressUseCase(this.repository);

  Future<BaseResponse<void>> call(String id) {
    return repository.deleteAddress(id);
  }
}
