import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/occasions_response_entity.dart';
import 'package:flower_app/features/occasion/domain/use_cases/get_occasions_use_case.dart';
import 'package:flower_app/features/occasion/presentation/view_model/intent/occasion_intent.dart';
import 'package:flower_app/features/occasion/presentation/view_model/state/occasion_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  final GetOccasionsUseCase _getOccasionsUseCase;

  OccasionCubit(this._getOccasionsUseCase) : super(const OccasionState());

  void handleIntent(OccasionIntent intent) {
    switch (intent) {
      case LoadOccasionsIntent():
        _getOccasions(intent.initialIndex);
      case SelectTabIntent():
        _selectTab(intent.index);
    }
  }

  Future<void> _getOccasions(int initialIndex) async {
    if (state.status == OccasionStatus.loading) return;

    emit(state.copyWith(status: OccasionStatus.loading));

    final result = await _getOccasionsUseCase();

    switch (result) {
      case SuccessBaseResponse<OccasionsResponseEntity>():
        final occasions = result.data.occasions ?? [];
        emit(
          state.copyWith(
            status: OccasionStatus.success,
            occasions: occasions,
            selectedTabIndex: initialIndex,
          ),
        );
      case ErrorBaseResponse<OccasionsResponseEntity>():
        emit(
          state.copyWith(
            status: OccasionStatus.failure,
            errorMessage: result.errorMessage,
          ),
        );
    }
  }

  void _selectTab(int index) {
    if (state.status == OccasionStatus.success) {
      emit(state.copyWith(selectedTabIndex: index));
    }
  }
}
