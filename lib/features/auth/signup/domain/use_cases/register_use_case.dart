import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../model/register_details.dart';
import '../model/register_params.dart';
import '../repositories/register_repo_contract.dart';

@injectable
class RegisterUseCase {
  final RegisterRepoContract registerRepo;
  RegisterUseCase(this.registerRepo);

  Future<BaseResponse<RegisterDetails>> call(RegisterParams params) =>
      registerRepo.register(params);
}
