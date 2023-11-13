import 'dart:convert';
import 'package:firebase_and_local_notification/notification/local_notification/galobal_settings.dart';
import 'package:firebase_and_local_notification/notification/models/noti_payload_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GiveNotificationAlert {
  Future<void> showNotificationWithActionButtons(
      NotiPayloadParams message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      notiifcationChannelIdForAndroid,
      notiifcationChannelNameForAndroid,
      channelDescription: 'Letsconnect123',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          viewAction,
          'View',
          showsUserInterface: true,
          cancelNotification: false,
          titleColor: Color.fromARGB(255, 255, 0, 0),
          icon: DrawableResourceAndroidBitmap('secondary_icon'),
        ),
        AndroidNotificationAction(
          closeAction,
          'Close',
          icon: DrawableResourceAndroidBitmap('secondary_icon'),
        ),
      ],
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id++,
      message.title.toString(),
      message.message.toString(),
      notificationDetails,
      payload: jsonEncode(message.toMap()),
    );
  }

  Future<void> showNotification(NotiPayloadParams message) async {
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
    _updateBadgeCount(message);
  }

  void _updateBadgeCount(NotiPayloadParams message) {
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
}
