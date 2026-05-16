import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/occasion/data/datasources/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/domain/entities/occasions_response_entity.dart';
import 'package:flower_app/features/occasion/domain/repositories/occasion_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionRepoContract)
class OccasionRepositoryImpl implements OccasionRepoContract {
  final OccasionRemoteDataSource _remoteDataSource;

  OccasionRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<OccasionsResponseEntity>> getOccasions() async {
    try {
      final response = await _remoteDataSource.getOccasions();
      return SuccessBaseResponse(data: response.toEntity());
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }
}
