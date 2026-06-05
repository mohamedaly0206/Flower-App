import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flower_app/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request_dto.dart';
import 'package:flower_app/features/checkout/data/models/response/checkout_response_dto.dart';

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSourceContract {
  @override
  final CheckoutApiClient apiClient;

  CheckoutRemoteDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<CheckoutResponseDto>> checkoutCashOrder(
    CheckoutRequestDto checkoutRequest,
  ) async {
    try {
      final response = await apiClient.checkoutCashOrder(checkoutRequest);
      return SuccessBaseResponse<CheckoutResponseDto>(data: response);
    } catch (e) {
      return ErrorBaseResponse<CheckoutResponseDto>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
