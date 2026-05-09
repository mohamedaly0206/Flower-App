import 'package:flower_app/core/errors/failures.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../domain/model/register_details.dart';
import '../../domain/model/register_params.dart';
import '../../domain/repositories/register_repo_contract.dart';
import '../data_sources/register_remote_datasource_contract.dart';
import '../model/register_request.dart';

@Injectable(as: RegisterRepoContract)
class RegisterRepoImpl implements RegisterRepoContract {
  final RegisterRemoteDatasourceContract _remoteDatasource;
  RegisterRepoImpl(this._remoteDatasource);

  @override
  Future<BaseResponse<RegisterDetails>> register(RegisterParams params) async {
    try {
      final request = RegisterRequest.fromParams(params);
      final result = await _remoteDatasource.register(request);
      final domain = result.toDomain();
      return SuccessBaseResponse(data: domain);
    } catch (e) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
