import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:http/http.dart' as http;

class PiCameraScreen extends StatefulWidget {
  const PiCameraScreen({super.key});

  @override
  State<PiCameraScreen> createState() => _PiCameraScreenState();
}

class _PiCameraScreenState extends State<PiCameraScreen> {
  bool isRecording = false;
  bool isPhoto = true; // Toggle between photo and video mode

  Future<void> _triggerAutofocus(BuildContext context) async {
    const autofocusUrl = 'http://127.0.0.1:5000/autofocus';
    try {
      final response = await http.post(Uri.parse(autofocusUrl));
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Autofocus triggered!")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to autofocus: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> _toggleRecording() async {
    const recordUrl = 'http://127.0.0.1:5000/record';
    try {
      final response = await http.post(
        Uri.parse(recordUrl),
        body: {'action': isRecording ? 'stop' : 'start'},
      );
      if (response.statusCode == 200) {
        setState(() => isRecording = !isRecording);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isRecording ? "Recording started" : "Recording stopped",
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Recording error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    const streamUrl = 'http://127.0.0.1:5000/video_feed';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Top controls
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.white),
                        onPressed: () {}, // TODO: Implement delete
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {}, // TODO: Implement brightness
                      ),
                      IconButton(
                        icon: const Icon(Icons.zoom_in, color: Colors.white),
                        onPressed: () {}, // TODO: Implement zoom
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                        onPressed: () {}, // TODO: Implement info
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Camera feed
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: WebViewStream(url: streamUrl),
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mode selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => setState(() => isPhoto = true),
                        child: Text(
                          'Photo',
                          style: TextStyle(
                            color: isPhoto ? Colors.white : Colors.grey,
                            fontWeight:
                                isPhoto ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => isPhoto = false),
                        child: Text(
                          'Video',
                          style: TextStyle(
                            color: !isPhoto ? Colors.white : Colors.grey,
                            fontWeight:
                                !isPhoto ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Camera controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {}, // TODO: Implement gallery
                      ),
                      GestureDetector(
                        onTap:
                            isPhoto
                                ? () => _triggerAutofocus(context)
                                : _toggleRecording,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            color:
                                isRecording && !isPhoto
                                    ? Colors.red
                                    : Colors.transparent,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cameraswitch,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {}, // TODO: Implement camera switch
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
    return Mjpeg(
      stream: url,
      isLive: true,
      fit: BoxFit.cover,
      error:
          (context, error, stackTrace) =>
              const Center(child: Text("Failed to load video stream")),
    );
  }
}
