import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';

class NotificationsStates extends Equatable {
  final BaseState getNotificationsState;

  const NotificationsStates({this.getNotificationsState = const BaseState()});

  NotificationsStates copyWith({BaseState? getNotificationsState}) {
    return NotificationsStates(
      getNotificationsState:
          getNotificationsState ?? this.getNotificationsState,
    );
  }

  @override
  List<Object?> get props => [getNotificationsState];
}
