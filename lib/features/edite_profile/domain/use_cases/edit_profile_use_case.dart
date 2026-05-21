import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/edite_profile/domain/entities/user_profile_entity.dart';
import 'package:flower_app/features/edite_profile/domain/repositories/edite_profile_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final EditeProfileRepoContract _repository;

  EditProfileUseCase(this._repository);

  Future<BaseResponse<UserProfileEntity>> call(Map<String, dynamic> body) {
    return _repository.editProfile(body);
  }
}
