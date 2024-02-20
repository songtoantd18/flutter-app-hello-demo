import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NotificationFunctions {
  Future<String> getDeviceToken() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return deviceToken ?? "";
  }

  void showNotification(
      String title, String description, BuildContext context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: title,
      desc: description,
      buttons: [
        DialogButton(
          child: Text(
            "COOL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  Future<void> getDeviceTokenAndShowNotification(BuildContext context) async {
    String deviceToken = await getDeviceToken();
    print("Device Token: $deviceToken");

    // Sử dụng context trong chức năng này
    showNotification("Notification Title", "Notification Description", context);
  }
}
