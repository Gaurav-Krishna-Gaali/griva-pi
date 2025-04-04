import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class PiCameraScreen extends StatelessWidget {
  const PiCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const streamUrl = 'http://127.0.0.1:5000/video_feed';

    return Scaffold(
      appBar: AppBar(title: const Text("Raspberry Pi Stream")),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text("Live MJPEG Stream"),
          Expanded(child: WebViewStream(url: streamUrl)),
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
        stream: url, // e.g. http://<raspberry-pi-ip>:5000/video_feed
        isLive: true,
        error: (context, error, stackTrace) =>
            const Center(child: Text("Failed to load video stream")),
      ),
    );
  }
}
