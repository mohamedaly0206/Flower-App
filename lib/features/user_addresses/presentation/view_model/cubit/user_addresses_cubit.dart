import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/features/user_addresses/domain/use_cases/user_addresses_use_case.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/intent/user_addresses_intent.dart';
import 'package:flower_app/features/user_addresses/presentation/view_model/state/user_addresses_state.dart';
import 'package:flower_app/config/base_response/base_response.dart';

@injectable
class UserAddressesCubit extends Cubit<UserAddressesState> {
  final UserAddressesUseCase _getAddressesUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  UserAddressesCubit(this._getAddressesUseCase, this._deleteAddressUseCase)
    : super(const UserAddressesState());

  void handleIntent(UserAddressesIntent intent) {
    switch (intent) {
      case FetchUserAddressesIntent():
        _fetchAddresses();

      case DeleteAddressIntent():
        _deleteAddress(intent.id);

      case NavigateToAddAddressIntent():
      // navigation handled in UI

      case NavigateToEditAddressIntent():
      // navigation handled in UI
    }
  }

  Future<void> _fetchAddresses() async {
    emit(state.copyWith(status: UserAddressesStatus.loading));

    final response = await _getAddressesUseCase();

    switch (response) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.success,
            addresses: response.data.addresses ?? [],
            clearError: true,
          ),
        );

      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.error,
            errorMessage: response.errorMessage,
          ),
        );
    }
  }

  Future<void> _deleteAddress(String id) async {
    emit(state.copyWith(status: UserAddressesStatus.deleting));

    final response = await _deleteAddressUseCase(id);

    switch (response) {
      case SuccessBaseResponse():
        final updatedList =
            (state.addresses ?? []).where((e) => e.id != id).toList();

        emit(
          state.copyWith(
            status: UserAddressesStatus.success,
            addresses: updatedList,
            clearError: true,
          ),
        );

      case ErrorBaseResponse():
        emit(
          state.copyWith(
            status: UserAddressesStatus.error,
            errorMessage: response.errorMessage,
          ),
        );
    }
  }
}
