import '../../../../../config/base_response/base_response.dart';
import '../model/register_details.dart';
import '../model/register_params.dart';

abstract interface class RegisterRepoContract {
  Future<BaseResponse<RegisterDetails>> register(RegisterParams params);
}
