import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/security_storage/security_storage.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/notifications/domain/use_cases/get_notifications_use_case.dart';
import 'package:flower_app/features/notifications/presentation/view_model/intent/notifications_intent.dart';
import 'package:flower_app/features/notifications/presentation/view_model/state/notifications_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationsCubit extends Cubit<NotificationsStates> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final SecurityStorage _securityStorage;

  NotificationsCubit(this._getNotificationsUseCase, this._securityStorage)
    : super(const NotificationsStates());

  void handleIntent(NotificationsIntent intent) {
    switch (intent) {
      case FetchNotificationsIntent():
        fetchNotifications();
    }
  }

  Future<void> fetchNotifications() async {
    emit(state.copyWith(getNotificationsState: BaseState(isLoading: true)));

    final userId = await _securityStorage.getSecuredString(AppStrings.userId);
    if (userId.isEmpty) {
      emit(
        state.copyWith(
          getNotificationsState: BaseState(
            isLoading: false,
            errorMessage: AppStrings.userIdNotFound,
          ),
        ),
      );
      return;
    }

    final result = await _getNotificationsUseCase(userId);

    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            getNotificationsState: BaseState(
              isLoading: false,
              data: result.data,
            ),
          ),
        );
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            getNotificationsState: BaseState(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }
}
