import 'package:flower_app/features/occasion/data/models/occasions_response.dart';

abstract interface class OccasionRemoteDataSource {
  Future<OccasionsResponse> getOccasions();
}
