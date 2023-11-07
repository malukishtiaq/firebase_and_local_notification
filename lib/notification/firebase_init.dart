import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'noti_payload_params.dart';
import 'process_recieved_notification.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotiPayloadParams notiPayloadParams =
      FBaseConnect.getNotiPayloadParams(message);

  await FgMsg.via.handlePushNotification(notiPayloadParams,
      isAppLaunch: false, showBannerNotification: true);
}

class FBaseConnect {
  static Future<void> firebaseInit() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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

  static void setupFirebase() {
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onMessage);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> onMessage(RemoteMessage? message) async {
    var notiPayload = getNotiPayloadParams(message!);
    await FgMsg.via.handlePushNotification(notiPayload, isAppLaunch: false);
  }

  static NotiPayloadParams getNotiPayloadParams(RemoteMessage message) {
    NotiPayloadParams model = notiPayloadParamsFromMap(
      json.encode(message.data),
    );
    return model;
  }
}
