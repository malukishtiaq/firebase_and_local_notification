import 'package:flutter/material.dart';

import '../models/noti_payload_params.dart';

class NotificationActions {
  static final NotificationActions via = NotificationActions._internal();

  NotificationActions._internal();

  Future<void> onSettingAction(
      NotiPayloadParams model, BuildContext context) async {
    try {
      //do something or go to setting page
      //show some alert or just do some logic
    } catch (e) {
      print(e);
    }
  }

  Future<void> onHomeAction(
      NotiPayloadParams model, BuildContext context) async {
    try {
      //do something or go to home page
      //nevigate t certain page.
    } catch (e) {
      print(e);
    }
  }
}
