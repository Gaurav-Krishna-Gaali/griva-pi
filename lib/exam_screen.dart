import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';  


class PiCameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const streamUrl = "http://127.0.0.1:5000/video_feed";

    return Scaffold(
      appBar: AppBar(title: Text("Raspberry Pi Stream")),
      body: Column(
        children: [
          Expanded(child: MJPEGViewer(streamUrl: streamUrl)),
          ElevatedButton(
            onPressed: triggerAutofocus,
            child: Text("Trigger Autofocus"),
          ),
        ],
      ),
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


class MJPEGViewer extends StatefulWidget {
  final String streamUrl;
  const MJPEGViewer({Key? key, required this.streamUrl}) : super(key: key);

  @override
  State<MJPEGViewer> createState() => _MJPEGViewerState();
}

class _MJPEGViewerState extends State<MJPEGViewer> {
  late String currentFrameUrl;
  Timer? timer;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    currentFrameUrl = widget.streamUrl;
    
    // Reduced refresh rate to 30fps (approximately)
    timer = Timer.periodic(Duration(milliseconds: 33), (_) {
      if (mounted) {
        setState(() {
          currentFrameUrl = widget.streamUrl + "?t=${DateTime.now().millisecondsSinceEpoch}";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      currentFrameUrl,
      gaplessPlayback: true,
      fit: BoxFit.contain,
      headers: {
        'Accept': 'multipart/x-mixed-replace; boundary=frame',
        'Connection': 'keep-alive',
      },
      loadingBuilder: (context, child, progress) {
        if (progress == null) {
          isConnected = true;
          return child;
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Connecting to stream...'),
            ],
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        isConnected = false;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text('Failed to connect to stream\nPlease check if the server is running'),
            ],
          ),
        );
      },
    );
  }
}
