import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/core/shared_features/user_addresses/data/datasources/user_addresses_remote_data_source.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/entities/user_addresses_body.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/entities/user_addresses_entity.dart';
import 'package:flower_app/core/shared_features/user_addresses/domain/repositories/user_addresses_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserAddressesRepoContract)
class UserAddressesRepoImpl implements UserAddressesRepoContract {
  final UserAddressesRemoteDataSource _remoteDataSource;

  UserAddressesRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<UserAddressesEntity>> getUserAddresses() async {
    try {
      final response = await _remoteDataSource.getUserAddresses();

      return SuccessBaseResponse(data: response.toEntity());
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<void>> addAddress(UserAddressesBody body) async {
    try {
      await _remoteDataSource.addAddress(body.toJson());
      return SuccessBaseResponse<void>(data: null);
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<void>> updateAddress(
    String id,
    UserAddressesBody body,
  ) async {
    try {
      await _remoteDataSource.updateAddress(id, body.toJson());

      return SuccessBaseResponse<void>(data: null);
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<void>> deleteAddress(String id) async {
    try {
      await _remoteDataSource.deleteAddress(id);

      return SuccessBaseResponse<void>(data: null);
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }
}
