// notification.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void initNotifications() async {
  print('hello word--------------------------------------------');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
    String? title = remoteMessage.notification!.title;
    String? description = remoteMessage.notification!.body;

    Alert(
      context: navigatorKey.currentContext!,
      type: AlertType.error,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(navigatorKey.currentContext!),
          width: 120,
        )
      ],
    ).show();
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Handle the background message here
}

Future getDeviceToken() async {
  FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
  String? deviceToken = await _firebaseMessage.getToken();
  print('token-------------------------$deviceToken');

  return (deviceToken == null) ? "" : deviceToken;
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
