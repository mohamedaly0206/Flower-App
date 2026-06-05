import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flower_app/features/checkout/data/models/request/checkout_request.dart';
import 'package:flower_app/features/checkout/data/models/response/checkout_response_dto.dart';
import 'package:flower_app/features/checkout/domain/entities/response/checkout_response_entity.dart';
import 'package:flower_app/features/checkout/domain/repositories/checkout_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRepoContract)
class CheckoutRepoImpl implements CheckoutRepoContract {
  final CheckoutRemoteDataSourceContract checkoutRemoteDataSourceContract;
  CheckoutRepoImpl(this.checkoutRemoteDataSourceContract);

  @override
  Future<BaseResponse<CheckoutResponseEntity>> checkoutCashOrder(
    CheckoutRequest checkoutRequest,
  ) async {
    final response = await checkoutRemoteDataSourceContract.checkoutCashOrder(
      checkoutRequest,
    );
    switch (response) {
      case SuccessBaseResponse<CheckoutResponseDto>():
        return SuccessBaseResponse<CheckoutResponseEntity>(
          data: response.data.toDomain(),
        );
      case ErrorBaseResponse<CheckoutResponseDto>():
        return ErrorBaseResponse<CheckoutResponseEntity>(
          errorMessage: response.errorMessage,
        );
    }
  }
}
