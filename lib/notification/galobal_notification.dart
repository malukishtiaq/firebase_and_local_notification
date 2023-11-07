import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'noti_payload_params.dart';
import 'process_recieved_notification.dart';
import 'incoming_notif_model.dart';

@pragma('vm:entry-point')
Future<void> notificationTapBackground(
    NotificationResponse notificationResponse) async {
  Fluttertoast.showToast(msg: "this global 15 notificationTapBackground");
  processFgNoti(notificationResponse);
}

bool isNotificationAlertShown = false;
Function? handleCallTermination;
int id = 0;
final StreamController<IncomingNotif> didReceiveLocalNotificationStream =
    StreamController<IncomingNotif>.broadcast();
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();
const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');
const String portName = 'notification_send_port';
String? selectedNotificationPayload;
const String navigationActionId = 'id_3';
const String darwinNotificationCategoryText = 'textCategory';
const String darwinNotificationCategoryPlain = 'plainCategory';
const String notiifcationChannelIdForAndroid = 'FibAndLocalNotification';
const String notiifcationChannelNameForAndroid = 'FibAndLocalNotification';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> localNotificationInit() async {
  try {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload =
          notificationAppLaunchDetails!.notificationResponse?.payload;
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher_round');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        Fluttertoast.showToast(
            msg: "this global 57 onDidReceiveLocalNotification $body");
      },
      notificationCategories: <DarwinNotificationCategory>[
        DarwinNotificationCategory(
          darwinNotificationCategoryText,
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.text(
              'text_1',
              'Action 1',
              buttonTitle: 'Send',
              placeholder: 'Placeholder',
            ),
          ],
        ),
        DarwinNotificationCategory(
          darwinNotificationCategoryPlain,
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain('id_1', 'Action 1'),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ],
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        processFgNoti(notificationResponse, isAppLaunch: true);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  } catch (e) {
    print('exception>> e');
  }
}

Future<void> requestNotificationPermissions() async {
  if (Platform.isIOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  } else if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final bool? grantedNotificationPermission =
        await androidImplementation?.requestNotificationsPermission();
    if (grantedNotificationPermission != true) {
      Fluttertoast.showToast(msg: 'Notification permisions are required');
    }
  }
}

void processFgNoti(NotificationResponse notificationResponse,
    {bool isAppLaunch = false}) {
  var jsonData = jsonDecode(notificationResponse.payload.toString());
  NotiPayloadParams notiPayloadParams = NotiPayloadParams.fromMap(jsonData);
  FgMsg.via.handlePushNotification(notiPayloadParams, isAppLaunch: isAppLaunch);
}
