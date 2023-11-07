# firebase_and_local_notification
A comprehensive Flutter project for integrating and managing Firebase Cloud Messaging (FCM) and local notifications. Features background message handling, interactive notification responses, and user-centric notification controls.

# Implementing Firebase and Local Notifications in Flutter
Building a full-fledged Flutter application often requires the integration of notifications to enhance user engagement. This guide walks you through the implementation of both Firebase Cloud Messaging (FCM) for push notifications and local notifications within a Flutter application.

### Prerequisites
Before you start, make sure you have:

Setting Up Firebase Cloud Messaging
Before sending or receiving notifications, you must integrate your Flutter app with Firebase. This involves a few steps:

### Create a Firebase project in the Firebase Console.
Add your app to the project by following the setup instructions for iOS and Android.
Download the google-services.json file for Android and the GoogleService-Info.plist for iOS and place them in the respective directories of your Flutter project.
Initialize Firebase in your Flutter app.

Integrate Firebase into your Flutter application by following these steps:

### Add Firebase to Your Flutter App
Follow the instructions on the Firebase console to add your app to your Firebase project. Download the google-services.json file and place it in your Flutter project's android/app directory.

### Integrate Firebase SDK
Add firebase_core and firebase_messaging to your pubspec.yaml file and install them by running flutter pub get.

### Initialize Firebase
In your main Dart file, initialize Firebase as shown in the provided code snippet. Ensure you do this before calling runApp().

```

Future<void> main() async {
  await FBaseConnect.firebaseInit();
  runApp(const MyApp());
}

```

### Implementing Firebase Messaging
The FBaseConnect class handles the initialization and setup for Firebase Messaging:

#### Background Message Handler
Define a top-level or static function to handle background messages. This function must have the @pragma('vm:entry-point') annotation to ensure it's compiled into the binary.

```

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ... Handle background message
}

```

#### Foreground Message Setup
Inside firebaseInit(), set up the message handlers for both foreground messages and messages that occur when the app is in the background or terminated.

#### Handling Notifications
With FgMsg and NotificationActions, you can define custom actions based on the notification's payload:

#### Custom Actions
Based on the screen name provided in the notification's data payload, navigate the user to different screens or perform specific actions.

#### Showing Banner Notifications
Use the flutter_local_notifications package to display banner notifications. Customize the appearance for both Android and iOS platforms.

#### Notification Data Model
NotiPayloadParams is a data model representing the notification's payload. Use it to parse and handle the notification data.

#### Save Notification Data
Optionally, save the notification data locally for future reference.

#### Local Notifications
For local notifications, you use the flutter_local_notifications plugin:

#### Initialization
Configure and initialize the local notifications plugin. Define settings for both Android and iOS.

#### Handling Notification Tap
Define a function to handle the event when a user taps on a notification. This function can also be used to navigate to a specific screen in your app.

```

Future<void> notificationTapBackground(
    NotificationResponse notificationResponse) async {
  // ... Handle notification tap
}

```

#### Platform-Specific Configurations
Other then request notification permissions andadding google json, no need to configure android platform.

#### Badge Management
Use the flutter_app_badger plugin to update the badge count on the app icon based on the received notifications.

#### Conclusion
By integrating both Firebase and local notifications, you can ensure that your users are always engaged with timely and relevant updates. Remember to handle permissions, background processes, and data management appropriately to create a seamless user experience.

For a full implementation guide, including detailed code examples and explanations, refer to the Flutter documentation and respective plugin instructions on pub.dev.
# firebase_and_local_notification
=======
>>>>>>> 0a7fe56 (renamed branch)

# Implementing Firebase and Local Notifications in Flutter
Building a full-fledged Flutter application often requires the integration of notifications to enhance user engagement. This guide walks you through the implementation of both Firebase Cloud Messaging (FCM) for push notifications and local notifications within a Flutter application.

### Prerequisites
Before you start, make sure you have:

Setting Up Firebase Cloud Messaging
Before sending or receiving notifications, you must integrate your Flutter app with Firebase. This involves a few steps:

### Create a Firebase project in the Firebase Console.
Add your app to the project by following the setup instructions for iOS and Android.
Download the google-services.json file for Android and the GoogleService-Info.plist for iOS and place them in the respective directories of your Flutter project.
Initialize Firebase in your Flutter app.

Integrate Firebase into your Flutter application by following these steps:

### Add Firebase to Your Flutter App
Follow the instructions on the Firebase console to add your app to your Firebase project. Download the google-services.json file and place it in your Flutter project's android/app directory.

### Integrate Firebase SDK
Add firebase_core and firebase_messaging to your pubspec.yaml file and install them by running flutter pub get.

### Initialize Firebase
In your main Dart file, initialize Firebase as shown in the provided code snippet. Ensure you do this before calling runApp().

```

Future<void> main() async {
  await FBaseConnect.firebaseInit();
  runApp(const MyApp());
}

```

### Implementing Firebase Messaging
The FBaseConnect class handles the initialization and setup for Firebase Messaging:

#### Background Message Handler
Define a top-level or static function to handle background messages. This function must have the @pragma('vm:entry-point') annotation to ensure it's compiled into the binary.

```

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ... Handle background message
}

```

#### Foreground Message Setup
Inside firebaseInit(), set up the message handlers for both foreground messages and messages that occur when the app is in the background or terminated.

#### Handling Notifications
With FgMsg and NotificationActions, you can define custom actions based on the notification's payload:

#### Custom Actions
Based on the screen name provided in the notification's data payload, navigate the user to different screens or perform specific actions.

#### Showing Banner Notifications
Use the flutter_local_notifications package to display banner notifications. Customize the appearance for both Android and iOS platforms.

#### Notification Data Model
NotiPayloadParams is a data model representing the notification's payload. Use it to parse and handle the notification data.

#### Save Notification Data
Optionally, save the notification data locally for future reference.

#### Local Notifications
For local notifications, you use the flutter_local_notifications plugin:

#### Initialization
Configure and initialize the local notifications plugin. Define settings for both Android and iOS.

#### Handling Notification Tap
Define a function to handle the event when a user taps on a notification. This function can also be used to navigate to a specific screen in your app.

```

Future<void> notificationTapBackground(
    NotificationResponse notificationResponse) async {
  // ... Handle notification tap
}

```

#### Platform-Specific Configurations
Other then request notification permissions andadding google json, no need to configure android platform.

#### Badge Management
Use the flutter_app_badger plugin to update the badge count on the app icon based on the received notifications.

#### Conclusion
By integrating both Firebase and local notifications, you can ensure that your users are always engaged with timely and relevant updates. Remember to handle permissions, background processes, and data management appropriately to create a seamless user experience.

For a full implementation guide, including detailed code examples and explanations, refer to the Flutter documentation and respective plugin instructions on pub.dev.
