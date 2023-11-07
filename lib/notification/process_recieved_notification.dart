import 'dart:convert';
import 'dart:io';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'galobal_notification.dart';
import 'noti_payload_params.dart';
import 'notification_actions.dart';

int notifcationBadgeCounter = 0;

class FgMsg {
  static final FgMsg via = FgMsg._internal();
  FgMsg._internal();
  Future<void> handlePushNotification(NotiPayloadParams message,
      {bool isAppLaunch = false, bool showBannerNotification = false}) async {
    saveNotificationData(message);
    if (showBannerNotification) {
      await _showNotificationUpdateChannelDescription(message);
    } else {
      switch (message.screenName) {
        case "Home":
          NotificationActions.via.onHomeAction(message);
          break;
        case "Setting":
          NotificationActions.via.onSettingAction(message);
          break;
      }
    }
    if (Platform.isAndroid) {
      FlutterAppBadger.updateBadgeCount(notifcationBadgeCounter);
    }
  }

  Future<void> _showNotificationUpdateChannelDescription(
      NotiPayloadParams message) async {
    try {
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          const AndroidNotificationDetails(
        notiifcationChannelIdForAndroid,
        notiifcationChannelNameForAndroid,
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/round_icon'),
        importance: Importance.max,
        priority: Priority.max,
        timeoutAfter: 50000,
        ticker: 'ticker',
      );

      var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

      var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      if (message.message != "" && message.title != "") {
        await flutterLocalNotificationsPlugin.show(
          0,
          message.title.toString(),
          message.message.toString(),
          platformChannelSpecifics,
          payload: jsonEncode(message.toMap()),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg:
              'An error occurred while attempting to receive the notification');
    }
    if ("if client asks for badge" == "just remove this if") {
      updateBadgeCount(message);
    }
  }

  void updateBadgeCount(NotiPayloadParams message) {
    String? badgeString = message.badge;
    int? badgeNumber;

    if (badgeString != null && badgeString.trim().isNotEmpty) {
      try {
        badgeNumber = int.parse(badgeString);
        FlutterAppBadger.updateBadgeCount(badgeNumber);
      } catch (e) {
        Fluttertoast.showToast(msg: 'Unable to update the badge count');
        FlutterAppBadger.updateBadgeCount(1);
      }
    } else {
      FlutterAppBadger.updateBadgeCount(1);
      Fluttertoast.showToast(msg: 'Badge string is null or empty');
    }
  }

  Future<void> saveNotificationData(NotiPayloadParams notificaiton) async {
    try {
      //you can save in local database or prefrencies if you want.
    } catch (e) {
      print("");
    }
  }
}
