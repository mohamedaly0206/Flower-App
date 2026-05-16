import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/occasions_response_entity.dart';
import 'package:flower_app/features/occasion/domain/repositories/occasion_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionsUseCase {
  final OccasionRepoContract _occasionRepository;

  GetOccasionsUseCase(this._occasionRepository);

  Future<BaseResponse<OccasionsResponseEntity>> call() {
    return _occasionRepository.getOccasions();
  }
}
