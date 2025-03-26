# Navigate on WebView Events (FlutterFlow App)

This FlutterFlow-based mobile app demonstrates how to embed an external web application via WebView and respond to events triggered from that web app using JavaScript channels.

## Overview

The app listens for specific events sent by a web page (like `app_success` or `consent_granted`) loaded inside a WebView. When an event is received, the app navigates to different screens based on the event type.

## Use Case

This is useful for integrating web-based workflows (like consent forms, onboarding steps, etc.) into a native mobile app. Rather than rebuilding the web functionality, it can be embedded and controlled through simple event communication.

## WebView Integration

A custom widget is used to handle the WebView and listen for JavaScript messages:

```dart
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
    _controller.loadRequest(Uri.parse('https://web-app-with-event-posting.web.app/'));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
