class NotificationBlueprint {
  NotificationBlueprint({
    required this.platform,
    required this.notificationSave,
    this.message,
  });

  final String platform;
  final SaveData notificationSave;
  final NotificationPayload? message;

  // Convert the NotificationBlueprint object to JSON
  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'notificationSave': notificationSave.toJson(),
      'message': message?.toJson(),
    };
  }

  // Create a NotificationBlueprint object from JSON
  factory NotificationBlueprint.fromJson(Map<String, dynamic> json) {
    return NotificationBlueprint(
      platform: json['platform'],
      notificationSave: SaveData.fromJson(json['notificationSave']),
      message: json['message'] != null
          ? NotificationPayload.fromJson(json['message'])
          : null,
    );
  }
}

class NotificationPayload {
  final String to;
  final String priority;
  final bool contentAvailable;
  final dynamic data;
  final APNS apns;
  final Android android;

  NotificationPayload({
    required this.to,
    required this.priority,
    required this.contentAvailable,
    required this.data,
    required this.apns,
    required this.android,
  });

  Map<String, dynamic> toJson() => {
        'to': to,
        'priority': priority,
        'content_available': contentAvailable,
        'data': data,
        'apns': apns.toJson(),
        'android': android.toJson(),
      };

  factory NotificationPayload.fromJson(Map<String, dynamic> json) {
    return NotificationPayload(
      to: json['to'],
      priority: json['priority'],
      contentAvailable: json['content_available'],
      data: json['data'],
      apns: APNS.fromJson(json['apns']),
      android: Android.fromJson(json['android']),
    );
  }
}

class SaveData {
  final String? memberIdPrimary;
  final String? memberIdSecondary;
  final String? tag;
  final String? text;
  final dynamic notificationTime;
  final String? json;
  String? memberNotificationId;

  SaveData({
    required this.memberIdPrimary,
    required this.memberIdSecondary,
    required this.tag,
    required this.text,
    required this.notificationTime,
    required this.json,
    this.memberNotificationId = "",
  });

  Map<String, dynamic> toJson() => {
        'MemberId_Primary': memberIdPrimary,
        'MemberId_Secondary': memberIdSecondary,
        'tag': tag,
        'text': text,
        'notificationTime': notificationTime,
        'json': json,
        'memberNotificationId': memberNotificationId,
      };

  factory SaveData.fromJson(Map<String, dynamic> json) {
    return SaveData(
      memberIdPrimary: json['MemberId_Primary'],
      memberIdSecondary: json['MemberId_Secondary'],
      tag: json['tag'],
      text: json['text'],
      notificationTime: json['notificationTime'],
      json: json['json'],
      memberNotificationId: json['memberNotificationId'],
    );
  }
}

class APNS {
  final Payload payload;

  APNS({
    required this.payload,
  });

  Map<String, dynamic> toJson() => {
        'payload': payload.toJson(),
      };

  factory APNS.fromJson(Map<String, dynamic> json) {
    return APNS(
      payload: Payload.fromJson(json['payload']),
    );
  }
}

class Payload {
  final APS aps;

  Payload({
    required this.aps,
  });

  Map<String, dynamic> toJson() => {
        'aps': aps.toJson(),
      };

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      aps: APS.fromJson(json['aps']),
    );
  }
}

class APS {
  final int contentAvailable;

  APS({
    required this.contentAvailable,
  });

  Map<String, dynamic> toJson() => {
        'content-available': contentAvailable,
      };

  factory APS.fromJson(Map<String, dynamic> json) {
    return APS(
      contentAvailable: json['content-available'],
    );
  }
}

class Android {
  final String priority;
  final AndroidNotification notification;

  Android({
    required this.priority,
    required this.notification,
  });

  Map<String, dynamic> toJson() => {
        'priority': priority,
        'notification': notification.toJson(),
      };

  factory Android.fromJson(Map<String, dynamic> json) {
    return Android(
      priority: json['priority'],
      notification: AndroidNotification.fromJson(json['notification']),
    );
  }
}

class AndroidNotification {
  final String sound;

  AndroidNotification({
    required this.sound,
  });

  Map<String, dynamic> toJson() => {
        'sound': sound,
      };

  factory AndroidNotification.fromJson(Map<String, dynamic> json) {
    return AndroidNotification(
      sound: json['sound'],
    );
  }
}
