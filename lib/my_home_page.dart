import 'dart:convert';

import 'package:firebase_and_local_notification/notification/recieved/process_recieved_notification.dart';
import 'package:flutter/material.dart';

import 'notification/local_notification/galobal_settings.dart';
import 'notification/models/noti_payload_params.dart';
import 'notification/models/received_notification.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  initState() {
    configureDidReceiveLocalNotificationSubject();
    configureSelectNotificationSubject();
    super.initState();
  }

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream.listen(
      (ReceivedNotification receivedNotification) async {
        var jsonData = jsonDecode(receivedNotification.payload ?? "");
        NotiPayloadParams notiPayloadParams =
            NotiPayloadParams.fromMap(jsonData);
        await ProcessNotification.via
            .handlePushNotification(notiPayloadParams, context);
      },
    );
  }

  void configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      var jsonData = jsonDecode(payload.toString());
      NotiPayloadParams notiPayloadParams = NotiPayloadParams.fromMap(jsonData);
      await ProcessNotification.via
          .handlePushNotification(notiPayloadParams, context);
    });
  }
}
