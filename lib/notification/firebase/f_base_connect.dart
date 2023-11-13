import 'package:firebase_and_local_notification/notification/firebase/check_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  CheckNotification checkNotification = CheckNotification();
  checkNotification.notificationArrived(message);
}

class FBaseConnect {
  Future<void> firebaseInit() async {
    await Firebase.initializeApp();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: false,
    );
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    setupFirebase();
  }

  void setupFirebase() {
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessage);
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> onMessage(RemoteMessage? message) async {
    CheckNotification checkNotification = CheckNotification();
    checkNotification.notificationArrived(message);
  }
}
