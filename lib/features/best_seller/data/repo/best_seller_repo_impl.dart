import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';
import 'package:flower_app/features/best_seller/domain/models/best_seller_model.dart';
import 'package:flower_app/features/best_seller/domain/repo/best_seller_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRepoContract)
class BestSellerRepoImpl implements BestSellerRepoContract {
  final BestSellerRemoteDataSourceContract _bestSellerRemoteDataSourceContract;

  BestSellerRepoImpl(this._bestSellerRemoteDataSourceContract);
  @override
  Future<BaseResponse<List<BestSellerModel>>> getBestSeller() async {
    final response = await _bestSellerRemoteDataSourceContract.getBestSeller();
    switch (response) {
      case SuccessBaseResponse<List<BestSellerDto>>():
        return SuccessBaseResponse<List<BestSellerModel>>(
          data: response.data.map((e) => e.toDomain()).toList(),
        );
      case ErrorBaseResponse<List<BestSellerDto>> errorResponse:
        return ErrorBaseResponse<List<BestSellerModel>>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
