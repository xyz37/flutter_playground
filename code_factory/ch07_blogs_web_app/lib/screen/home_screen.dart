// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  late WebViewController controller;

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeUrl = 'https://blog.codefactory.ai';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Code factory'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.goBack();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () {
              controller.goForward();
            },
            icon: const Icon(Icons.arrow_forward),
          ),
          IconButton(
            onPressed: () {
              controller.loadUrl(homeUrl);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      // body: const Text('Home screen'),
      body: WebView(
        initialUrl: homeUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
      ),
    );
  }
}
