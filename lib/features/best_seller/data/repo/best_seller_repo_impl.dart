import 'package:flower_app/core/shared_features/products/domain/entities/products_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/repo/best_seller_repo_contract.dart';
import '../data_sources/best_seller_remote_data_source_contract.dart';
import '../models/best_seller_dto.dart';

@Injectable(as: BestSellerRepoContract)
class BestSellerRepoImpl implements BestSellerRepoContract {
  final BestSellerRemoteDataSourceContract _bestSellerRemoteDataSourceContract;

  BestSellerRepoImpl(this._bestSellerRemoteDataSourceContract);

  @override
  Future<BaseResponse<ProductsResponseEntity>> getBestSeller() async {
    final response = await _bestSellerRemoteDataSourceContract.getBestSeller();
    switch (response) {
      case SuccessBaseResponse<BestSellerDto>():
        return SuccessBaseResponse<ProductsResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<BestSellerDto> errorResponse:
        return ErrorBaseResponse<ProductsResponseEntity>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
