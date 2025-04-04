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

  @override
  void initState() {
    super.initState();
    currentFrameUrl = widget.streamUrl + "?time=${DateTime.now().millisecondsSinceEpoch}";

    timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      setState(() {
        currentFrameUrl = widget.streamUrl + "?time=${DateTime.now().millisecondsSinceEpoch}";
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      currentFrameUrl,
      gaplessPlayback: true,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, progress) {
        return progress == null
            ? child
            : const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(child: Text('Failed to load stream'));
      },
    );
  }
}
