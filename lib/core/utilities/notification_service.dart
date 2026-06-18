import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

// receive notification when app is in background or terminated state
// will be called when user clicks on the notification and app is in background or terminated
@pragma('vm:entry-point')
//do not encrypt this function as it will be called by the system when the app is in background or terminated
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("app is in background or terminated: ${message.notification?.title}");
  }
}

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    // ask permission from device to receive notifications
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //will be removed
      if (kDebugMode) print('user accepted notification permission');
      await Future.delayed(const Duration(seconds: 2));

      try {
        String? token = await _fcm.getToken();
        if (kDebugMode) print("FCM Token: $token");
      } catch (e) {
        if (kDebugMode) print("Error fetching FCM token: $e");
      }

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // app is opened
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (kDebugMode) {
          print("app is opened and received a notification!");
          print("title: ${message.notification?.title}");
          print("body: ${message.notification?.body}");
        }
      });

      // user clicks on the notification and app is in background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (kDebugMode) {
          print("user clicked on the notification and app is in background!");
          print("data associated with the notification: ${message.data}");
        }
        //action move to specific screen based on the data in notification
      });

      // user clicks on the notification and app is in terminated state
      RemoteMessage? initialMessage = await _fcm.getInitialMessage();

      if (initialMessage != null) {
        if (kDebugMode) {
          print(
            "user clicked on the notification and app is in terminated state!",
          );
          print(
            "data associated with the notification: ${initialMessage.data}",
          );
        }
        //action move to specific screen based on the data in notification
      }
    }
  }
}
