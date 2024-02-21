import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../loginPage/loginPage.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with WidgetsBindingObserver {
  late String _deviceToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _initializeFirebase();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  Future<void> _initializeFirebase() async {
    await _requestPermissionAndDeviceToken();
    _setupFirebaseMessaging();
  }

  Future<void> _requestPermissionAndDeviceToken() async {
    await FirebaseMessaging.instance.requestPermission();
    _deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
    print("Device Token: $_deviceToken");
  }

  void _setupFirebaseMessaging() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  void _handleMessageOpenedApp(RemoteMessage remoteMessage) {
    _showNotificationAlert(remoteMessage.notification);
  }

  void _handleMessage(RemoteMessage message) {
    _showNotificationAlert(message.notification);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void _showNotificationAlert(RemoteNotification? notification) {
    String? title = notification?.title;
    String? description = notification?.body;

    Alert(
      context: context,
      type: AlertType.error,
      title: title ?? "Notification",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: LoginPage(),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App state: $state');
  }
}
