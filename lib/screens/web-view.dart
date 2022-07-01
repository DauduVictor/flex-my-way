import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends StatelessWidget {

  final String url;

  WebViewer({
    Key? key,
    required this.url
  }) : super(key: key);

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 16,
          ),
        ),
      ),
      body: WebView(
        initialUrl: ('https://$url'),
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (navigation) {
          return NavigationDecision.navigate;
        },
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
