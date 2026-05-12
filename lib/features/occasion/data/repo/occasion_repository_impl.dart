import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/occasion/data/datasources/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/data/models/occasions_response.dart';
import 'package:flower_app/features/occasion/domain/repo/occasion_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionRepository)
class OccasionRepositoryImpl implements OccasionRepository {
  final OccasionRemoteDataSource _remoteDataSource;

  OccasionRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<OccasionsResponse>> getOccasions() async {
    try {
      final response = await _remoteDataSource.getOccasions();
      return SuccessBaseResponse(data: response);
    } catch (error) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(error).errorMessage,
      );
    }
  }
}
