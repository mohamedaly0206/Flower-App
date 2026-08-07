import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/config/base_response/base_response.dart';
import 'package:flower_app/core/errors/failures.dart';
import 'package:flower_app/features/notifications/data/models/notification_model.dart';
import 'package:injectable/injectable.dart';

abstract interface class NotificationsRemoteDataSource {
  Future<BaseResponse<List<NotificationModel>>> getNotifications(String userId);
}

@Injectable(as: NotificationsRemoteDataSource)
class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<BaseResponse<List<NotificationModel>>> getNotifications(
    String userId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .orderBy('createdAt', descending: true)
          .get();

      return SuccessBaseResponse(
        data: snapshot.docs
            .map((doc) => NotificationModel.fromJson(doc.data(), doc.id))
            .toList(),
      );
    } on Exception catch (e) {
      return ErrorBaseResponse(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
