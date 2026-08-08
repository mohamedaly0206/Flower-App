import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/features/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:flower_app/features/notifications/data/models/notification_model.dart';
import 'package:flower_app/features/notifications/domain/entities/notification_entity.dart';
import 'package:flower_app/features/notifications/domain/repo/notifications_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource _remoteDataSource;

  NotificationsRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<NotificationEntity>>> getNotifications(
    String userId,
  ) async {
    final result = await _remoteDataSource.getNotifications(userId);
    switch (result) {
      case SuccessBaseResponse<List<NotificationModel>>():
        return SuccessBaseResponse<List<NotificationEntity>>(
          data: result.data.map((e) => e.toDomain()).toList(),
        );
      case ErrorBaseResponse<List<NotificationModel>>():
        return ErrorBaseResponse<List<NotificationEntity>>(
          errorMessage: result.errorMessage,
        );
    }
  }
}
