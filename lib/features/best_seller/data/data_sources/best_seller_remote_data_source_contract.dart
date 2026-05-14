import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';

abstract class BestSellerRemoteDataSourceContract {
  Future<BaseResponse<List<BestSellerDto>>> getBestSeller();
}
