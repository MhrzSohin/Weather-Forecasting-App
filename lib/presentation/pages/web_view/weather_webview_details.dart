import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WeatherWebviewDetails extends StatelessWidget {
  WeatherWebviewDetails({super.key});
  final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://www.accuweather.com'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: WebViewWidget(controller: webViewController),
    ));
  }
}
