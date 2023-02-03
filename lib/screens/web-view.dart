import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends StatelessWidget {

  final String url;

  const WebViewer({
    Key? key,
    required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(url));
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
      body: WebViewWidget(controller: webViewController),
    );
  }
}
