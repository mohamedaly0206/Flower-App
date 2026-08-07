import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:flower_app/features/notifications/domain/repo/notifications_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationsRepository _repository;

  GetNotificationsUseCase(this._repository);

  Future<BaseResponse<List<NotificationEntity>>> call(String userId) {
    return _repository.getNotifications(userId);
  }
}
