// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:webview_flutter/webview_flutter.dart';

class WebviewWithEvents extends StatefulWidget {
  const WebviewWithEvents({
    super.key,
    this.width,
    this.height,
    required this.navigateToSuccess,
    required this.navigateToConsent,
  });

  final double? width;
  final double? height;
  final Future Function() navigateToSuccess;
  final Future Function() navigateToConsent;

  @override
  State<WebviewWithEvents> createState() => _WebviewWithEventsState();
}

class _WebviewWithEventsState extends State<WebviewWithEvents> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (JavaScriptMessage message) {
          final msg = message.message;
          if (msg == 'app_success') {
            widget.navigateToSuccess();
          } else if (msg == 'consent_granted') {
            widget.navigateToConsent();
          }
        },
      );
    _controller
        .loadRequest(Uri.parse('https://web-app-with-event-posting.web.app/'));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
