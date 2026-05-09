import 'package:injectable/injectable.dart';

import '../../data/data_sources/register_remote_datasource_contract.dart';
import '../../data/model/register_request.dart';
import '../../data/model/register_response.dart';
import '../api_services/api_services.dart';

@Injectable(as: RegisterRemoteDatasourceContract)
class RegisterRemoteDatasourceImpl implements RegisterRemoteDatasourceContract {
  final RegisterApiService signupApiService;
  RegisterRemoteDatasourceImpl(this.signupApiService);

  @override
  Future<RegisterResponse> register(RegisterRequest request) =>
      signupApiService.register(request);
}
