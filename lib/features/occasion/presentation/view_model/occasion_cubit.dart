import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/occasion/domain/entities/occasions_response_entity.dart';
import 'package:flower_app/features/occasion/domain/use_cases/get_occasions_use_case.dart';
import 'package:flower_app/features/occasion/presentation/view_model/occasion_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionCubit extends Cubit<OccasionState> {
  final GetOccasionsUseCase _getOccasionsUseCase;

  OccasionCubit(this._getOccasionsUseCase) : super(const OccasionInitial());

  Future<void> getOccasions() async {
    if (state is OccasionLoading) return;

    emit(const OccasionLoading());

    final result = await _getOccasionsUseCase();

    switch (result) {
      case SuccessBaseResponse<OccasionsResponseEntity>():
        final occasions = result.data.occasions ?? [];
        emit(OccasionSuccess(occasions: occasions));
      case ErrorBaseResponse<OccasionsResponseEntity>():
        emit(OccasionFailure(result.errorMessage));
    }
  }

  void selectTab(int index) {
    if (state is OccasionSuccess) {
      final currentState = state as OccasionSuccess;
      emit(currentState.copyWith(selectedTabIndex: index));
    }
  }
}
