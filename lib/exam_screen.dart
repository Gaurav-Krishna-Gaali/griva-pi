import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:http/http.dart' as http;

class PiCameraScreen extends StatelessWidget {
  const PiCameraScreen({super.key});

  // 🔘 Trigger autofocus POST request
  Future<void> _triggerAutofocus(BuildContext context) async {
    const autofocusUrl = 'http://127.0.0.1:5000/autofocus'; // Replace with actual IP
    try {
      final response = await http.post(Uri.parse(autofocusUrl));
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Autofocus triggered!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to autofocus: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const streamUrl = 'http://127.0.0.1:5000/video_feed'; // Replace with actual Pi IP if needed

    return Scaffold(
      appBar: AppBar(title: const Text("Raspberry Pi Stream")),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text("Live MJPEG Stream"),
          Expanded(child: WebViewStream(url: streamUrl)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _triggerAutofocus(context),
            child: const Text("Trigger Autofocus"),
          ),
          const SizedBox(height: 10),
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
    return Center(
      child: Mjpeg(
        stream: url,
        isLive: true,
        error: (context, error, stackTrace) =>
            const Center(child: Text("Failed to load video stream")),
      ),
    );
  }
}
