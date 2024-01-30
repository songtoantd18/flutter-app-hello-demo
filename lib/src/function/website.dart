import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class MyWebView extends StatefulWidget {
  final String url;

  // Constructor to accept the URL parameter
  MyWebView(this.url);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String pageTitle = 'Web Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onPageFinished: (String url) {
          _updateTitle();
        },
      ),
    );
  }

  Future<void> _updateTitle() async {
    WebViewController controller = await _controller.future;
    String? title = await controller.getTitle(); // Change the type to String?

    if (title != null && title.isNotEmpty) {
      setState(() {
        pageTitle = title!;
      });
    } else {
      print("Title is null or empty.");
    }
  }
}
