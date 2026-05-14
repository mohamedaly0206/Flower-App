import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_model.dart';
import 'package:flower_app/features/best_seller/domain/repo/best_seller_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class BestSellerUseCase {
  final BestSellerRepoContract _bestSellerRepoContract;

  BestSellerUseCase(this._bestSellerRepoContract);
  Future<BaseResponse<List<BestSellerModel>>> call() async {
    return await _bestSellerRepoContract.getBestSeller();
  }
}
