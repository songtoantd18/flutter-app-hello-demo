import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_hello/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize firebase from firebase core plugin
  await Firebase.initializeApp();
  runApp(MyApp(homeScreen: HomePage()));
}

class MyApp extends StatefulWidget {
  final Widget? homeScreen;
  MyApp({this.homeScreen});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: this.widget.homeScreen,
    );
  }
}
