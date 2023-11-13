import 'package:firebase_and_local_notification/my_home_page.dart';
import 'package:flutter/material.dart';
import 'notification/firebase/f_base_connect.dart';

Future<void> main() async {
  FBaseConnect connect = FBaseConnect();
  await connect.firebaseInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
