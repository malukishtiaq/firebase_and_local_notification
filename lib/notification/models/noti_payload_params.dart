import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';

NotiPayloadParams getNotiPayloadParams(RemoteMessage message) {
  NotiPayloadParams model = notiPayloadParamsFromMap(
    json.encode(message.data),
  );
  return model;
}

NotiPayloadParams notiPayloadParamsFromMap(String str) =>
    NotiPayloadParams.fromMap(json.decode(str));

class NotiPayloadParams {
  NotiPayloadParams({
    this.screenName = "",
    this.title = "",
    this.message = "",
    this.date = "",
    this.status = "",
    this.route = "",
    this.badge = "",
  });

  String screenName = "";
  String title = "";
  String message = "";
  String date = "";
  String status = "";
  String route = "";
  String badge = "";

  factory NotiPayloadParams.fromMap(Map<String, dynamic> json) =>
      NotiPayloadParams(
        screenName: containsChecker(json, 'screen_name'),
        title: containsChecker(json, 'title'),
        message: containsChecker(json, 'message'),
        date: containsChecker(json, 'date'),
        status: 'unread',
        route: containsChecker(json, 'route'),
        badge: containsChecker(json, 'badge'),
      );

  Map<String, dynamic> toMap() {
    return {
      'screen_name': replaceNullWithEmptyString(screenName),
      'title': replaceNullWithEmptyString(title),
      'message': replaceNullWithEmptyString(message),
      'date': replaceNullWithEmptyString(date),
      'status': replaceNullWithEmptyString(status),
      'route': replaceNullWithEmptyString(route),
      'badge': replaceNullWithEmptyString(badge),
    };
  }

  String replaceNullWithEmptyString(value) {
    return value == null ? "" : value;
  }

  static String containsChecker(Map<String, dynamic> json, String key) {
    return json.containsKey(key) ? json[key] : "";
  }
}
