
---

### 📁 `README.md` for the Flutter App (`navigate_on_webview_events_app`)

```md
# Flutter WebView Listener App

This FlutterFlow-based app embeds an external web application using a WebView and listens to events emitted by it via `postMessage` and `JavaScriptChannel`.

## Overview

This project demonstrates how to:

- Load an external web app in a WebView.
- Listen to custom events (`app_success`, `consent_granted`) using `JavaScriptChannel`.
- Trigger navigation or custom logic in Flutter based on received events.

## Code Snippet

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
