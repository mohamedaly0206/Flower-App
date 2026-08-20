import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/notifications/domain/entities/notification_entity.dart';

abstract interface class NotificationsRepository {
  Future<BaseResponse<List<NotificationEntity>>> getNotifications(
    String userId,
  );
}
