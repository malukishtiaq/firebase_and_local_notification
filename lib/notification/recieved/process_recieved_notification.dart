import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import '../models/noti_payload_params.dart';
import 'notification_actions.dart';

int notifcationBadgeCounter = 0;

class ProcessNotification {
  static final ProcessNotification via = ProcessNotification._internal();
  ProcessNotification._internal();

  Future<void> handlePushNotification(
      NotiPayloadParams message, BuildContext context) async {
    saveNotificationData(message);

    switch (message.screenName) {
      case "Home":
        NotificationActions.via.onHomeAction(message, context);
        break;
      case "Setting":
        NotificationActions.via.onSettingAction(message, context);
        break;
    }
    if (Platform.isAndroid) {
      FlutterAppBadger.updateBadgeCount(notifcationBadgeCounter);
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
