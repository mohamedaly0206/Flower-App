import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/entities/user_addresses_body.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/repositories/user_addresses_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUseCase {
  final UserAddressesRepoContract repository;

  AddAddressUseCase(this.repository);

  Future<BaseResponse<void>> call(UserAddressesBody body) {
    return repository.addAddress(body);
  }
}
