import 'noti_payload_params.dart';

class NotificationActions {
  static final NotificationActions via = NotificationActions._internal();

  NotificationActions._internal();

  Future<void> onSettingAction(NotiPayloadParams model) async {
    try {
      //do something or go to setting page
    } catch (e) {
      print(e);
    }
  }

  Future<void> onHomeAction(NotiPayloadParams model) async {
    try {
      //do something or go to home page
    } catch (e) {
      print(e);
    }
  }
}
