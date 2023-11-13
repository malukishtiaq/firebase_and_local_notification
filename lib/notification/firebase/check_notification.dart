import 'package:firebase_and_local_notification/notification/local_notification/give_notification_alert.dart';
import 'package:firebase_and_local_notification/notification/models/noti_payload_params.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CheckNotification {
  NotiPayloadParams? _notificationArivedBefore;
  Future<void> notificationArrived(RemoteMessage? message) async {
    if ("currentUserId is still logged in" ==
        "check before showing notification to the user.") return;

    NotiPayloadParams notiPayload = getNotiPayloadParams(message!);
    CheckNotification connect = CheckNotification();
    if (connect.isNotificationDuplicate(notiPayload)) return;

    GiveNotificationAlert giveNotificationAlert = GiveNotificationAlert();
    await giveNotificationAlert.showNotification(notiPayload);
  }

  bool isNotificationDuplicate(notiPayload) {
    if (_notificationArivedBefore?.date ==
        "it can be timestamp or something ") {
      return true;
    }
    _notificationArivedBefore = notiPayload;
    return false;
  }
}
