import 'dart:async';
import 'dart:io';
import 'package:firebase_and_local_notification/notification/models/received_notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

//FlutterLocalNotificationsPlugin start
@pragma('vm:entry-point')
Future<void> notificationTapBackground(
    NotificationResponse notificationResponse) async {
  switch (notificationResponse.notificationResponseType) {
    case NotificationResponseType.selectedNotification:
      selectNotificationStream.add(notificationResponse.payload);
      break;
    case NotificationResponseType.selectedNotificationAction:
      if (notificationResponse.actionId == viewAction) {
        selectNotificationStream.add(notificationResponse.payload);
      }
      break;
  }
}

bool isNotificationAlertShown = false;
Function? handleCallTermination;
int id = 0;
const String urlLaunchActionId = 'id_1';
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();
const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');
const String portName = 'notification_send_port';
String? selectedNotificationPayload;
const String viewAction = 'viewAction';
const String closeAction = 'closeAction';
const String darwinNotificationCategoryText = 'textCategory';
const String darwinNotificationCategoryPlain = 'plainCategory';
const String notiifcationChannelIdForAndroid = 'Letsconnect123';
const String notiifcationChannelNameForAndroid = 'Letsconnect123';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class GlobalNotification {
  static NotificationAppLaunchDetails? notificationAppLaunchDetails;
  static String initialRoute = '';
  static Future<void> localNotificationInit() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');

      final DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          didReceiveLocalNotificationStream.add(
            ReceivedNotification(
              id: id,
              title: title,
              body: body,
              payload: payload,
            ),
          );
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
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              selectNotificationStream.add(notificationResponse.payload);
              break;
            case NotificationResponseType.selectedNotificationAction:
              if (notificationResponse.actionId == viewAction) {
                selectNotificationStream.add(notificationResponse.payload);
              }
              break;
          }
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );

      Future.delayed(const Duration(seconds: 3), () async {
        await didNotifcationLaunchApp();
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception in ${localNotificationInit.toString()}");
    }
  }

  static Future<void> didNotifcationLaunchApp() async {
    try {
      notificationAppLaunchDetails = await flutterLocalNotificationsPlugin
          .getNotificationAppLaunchDetails();
      if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        selectedNotificationPayload =
            notificationAppLaunchDetails!.notificationResponse?.payload;
        selectNotificationStream.add(selectedNotificationPayload);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Exception in didNotifcationLaunchApp");
    }
  }

  static Future<void> requestNotificationPermissions() async {
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
}

enum PushNotificationType { pushVoip, pushDynamic, pushData }
