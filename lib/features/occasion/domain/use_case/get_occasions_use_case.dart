import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/data/models/occasions_response.dart';
import 'package:flower_app/features/occasion/domain/repo/occasion_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionsUseCase {
  final OccasionRepository _occasionRepository;

  GetOccasionsUseCase(this._occasionRepository);

  Future<BaseResponse<OccasionsResponse>> call() {
    return _occasionRepository.getOccasions();
  }
}
