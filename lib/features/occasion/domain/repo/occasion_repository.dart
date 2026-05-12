import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/data/models/occasions_response.dart';

abstract class OccasionRepository {
  Future<BaseResponse<OccasionsResponse>> getOccasions();
}
