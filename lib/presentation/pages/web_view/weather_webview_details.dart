import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:showweatherapp/presentation/pages/home/home_view.dart';

class WeatherWebviewDetails extends StatefulWidget {
  const WeatherWebviewDetails({super.key});

  @override
  State<WeatherWebviewDetails> createState() => _WeatherWebviewDetailsState();
}

class _WeatherWebviewDetailsState extends State<WeatherWebviewDetails> {
  InAppWebViewController? inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final controller = inAppWebViewController;
        if (controller != null && await controller.canGoBack()) {
          controller.goBack();
        } else {
          Get.offAll(() => HomeView());
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Weather Details in Web",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: WebUri('https://www.accuweather.com/')),
                  initialSettings: InAppWebViewSettings(),
                  onWebViewCreated: (controller) {
                    inAppWebViewController = controller;
                  },
                ),
              )
            ],
          )),
    ));
  }
}
