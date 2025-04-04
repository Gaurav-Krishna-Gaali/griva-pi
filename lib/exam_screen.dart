import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PiCameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const streamUrl = "http://127.0.0.1:5000/video_feed";  // Replace with your actual Pi camera stream URL

    return Scaffold(
      appBar: AppBar(title: Text("Raspberry Pi Stream")),
      body: Column(
        children: [
          Expanded(
            child: WebViewStream(url: streamUrl),  // Displays live video stream
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

class WebViewStream extends StatelessWidget {
  final String url;
  const WebViewStream({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Text("Failed to load video stream"));
      },
    );
  }
}

Future<void> triggerAutofocus() async {
  final uri = Uri.parse('http://127.0.0.1:5000/autofocus');  // Replace with actual autofocus endpoint
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
