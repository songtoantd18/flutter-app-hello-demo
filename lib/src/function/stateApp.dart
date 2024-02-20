import 'package:flutter/material.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;

  void init() {
    WidgetsBinding.instance?.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    _appLifecycleState = state;

    final Map<AppLifecycleState, String> stateMessages = {
      AppLifecycleState.resumed: 'foreground',
      AppLifecycleState.inactive: 'inactive state',
      AppLifecycleState.paused: 'background',
      AppLifecycleState.detached: 'suspended state',
    };

    final message = stateMessages[state];
    print('App Lifecycle State: $_appLifecycleState');
    print('App is in $message');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLifecycleObserver _lifecycleObserver;

  @override
  void initState() {
    super.initState();
    _lifecycleObserver = AppLifecycleObserver();
    _lifecycleObserver.init();
  }

  @override
  void dispose() {
    _lifecycleObserver.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Lifecycle State'),
        ),
        body: Center(
          child: Text('Check the console for app state changes'),
        ),
      ),
    );
  }
}
