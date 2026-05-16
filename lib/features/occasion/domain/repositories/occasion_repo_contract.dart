import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/occasions_response_entity.dart';

abstract interface class OccasionRepoContract {
  Future<BaseResponse<OccasionsResponseEntity>> getOccasions();
}
