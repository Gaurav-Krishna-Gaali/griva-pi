import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PiCameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const streamUrl = "http://127.0.0.1:5000/video_feed";

    return Scaffold(
      appBar: AppBar(title: Text("Raspberry Pi Stream")),
      body: Column(
        children: [
          Expanded(
            child: WebViewStream(url: streamUrl),
          ),
          ElevatedButton(
            onPressed: triggerAutofocus,
            child: Text("Trigger Autofocus"),
          ),
        ],
      ),
    );
  }
}

class WebViewStream extends StatefulWidget {
  final String url;
  const WebViewStream({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewStream> createState() => _WebViewStreamState();
}

class _WebViewStreamState extends State<WebViewStream> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}

Future<void> triggerAutofocus() async {
  final uri = Uri.parse('http://127.0.0.1:5000/autofocus');
  try {
    final response = await http.post(uri);
    if (response.statusCode == 200) {
      debugPrint("Autofocus triggered");
    } else {
      debugPrint("Failed to trigger autofocus: ${response.body}");
    }
  } catch (e) {
    debugPrint("Error: $e");
  }
}
