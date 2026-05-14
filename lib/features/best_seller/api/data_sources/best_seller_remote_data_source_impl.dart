import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:flower_app/features/best_seller/data/data_sources/best_seller_remote_data_source_contract.dart';
import 'package:flower_app/features/best_seller/data/models/best_seller_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRemoteDataSourceContract)
class BestSellerRemoteDataSourceImpl
    implements BestSellerRemoteDataSourceContract {
  final BestSellerApiClient _bestSellerApiClient;

  BestSellerRemoteDataSourceImpl(this._bestSellerApiClient);
  @override
  Future<BaseResponse<List<BestSellerDto>>> getBestSeller() async {
    try {
      final response = await _bestSellerApiClient.getBestSellers();

      return SuccessBaseResponse<List<BestSellerDto>>(
        data: response.bestSellerDto ?? [],
      );
    } catch (e) {
      if (e is DioException) {
        return ErrorBaseResponse<List<BestSellerDto>>(
          errorMessage: e.message ?? 'Dio Exception',
        );
      } else if (e is TimeoutException) {
        return ErrorBaseResponse<List<BestSellerDto>>(
          errorMessage: e.message ?? 'Request Time out ,Please try again later',
        );
      }
      return ErrorBaseResponse<List<BestSellerDto>>(
        errorMessage: 'Something went wrong ,Please try again later',
      );
    }
  }
}
