import 'package:flower_app/features/occasion/api/occasion_api_client/occasion_api_client.dart';
import 'package:flower_app/features/occasion/data/datasources/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/data/models/occasions_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OccasionRemoteDataSource)
class OccasionRemoteDataSourceImpl implements OccasionRemoteDataSource {
  final OccasionApiClient _occasionApiClient;

  OccasionRemoteDataSourceImpl(this._occasionApiClient);

  @override
  Future<OccasionsResponse> getOccasions() {
    return _occasionApiClient.getOccasions();
  }
}
