import 'dart:async';

import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:flower_app/features/best_seller/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/shared_features/products/data/models/products_response.dart';

@Injectable(as: BestSellerRemoteDataSourceContract)
class BestSellerRemoteDataSourceImpl
    implements BestSellerRemoteDataSourceContract {
  final BestSellerApiClient _bestSellerApiClient;

  BestSellerRemoteDataSourceImpl(this._bestSellerApiClient);

  @override
  Future<BaseResponse<ProductsResponseDto>> getBestSeller() async {
    try {
      final response = await _bestSellerApiClient.getBestSellers();

      return SuccessBaseResponse<ProductsResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<ProductsResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
