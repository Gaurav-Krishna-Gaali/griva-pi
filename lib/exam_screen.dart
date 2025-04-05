import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:http/http.dart' as http;

class PiCameraScreen extends StatefulWidget {
  const PiCameraScreen({super.key});

  @override
  State<PiCameraScreen> createState() => _PiCameraScreenState();
}

class _PiCameraScreenState extends State<PiCameraScreen>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  bool isPhoto = true; // Toggle between photo and video mode
  bool isShutterPressed = false;
  bool isGreenFilterActive = false;
  bool showFlash = false;

  // Animation controller declared but initialized in initState
  late AnimationController _flashAnimationController;
  Animation<double>? _flashOpacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller properly
    _flashAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Initialize animation in initState
    _flashOpacityAnimation = Tween<double>(begin: 0.7, end: 0.0).animate(
      CurvedAnimation(parent: _flashAnimationController, curve: Curves.easeOut),
    );

    _flashAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            showFlash = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _flashAnimationController.dispose();
    super.dispose();
  }

  // Fixed method to prevent UI shaking
  Future<void> _triggerAutofocus(BuildContext context) async {
    const autofocusUrl = 'http://127.0.0.1:5000/autofocus';

    // Set state first to show visual feedback
    setState(() {
      isShutterPressed = true;
      showFlash = true;
    });

    // Reset and start the animation
    if (mounted) {
      _flashAnimationController.reset();
      _flashAnimationController.forward();
    }

    // Small delay to show button press animation
    await Future.delayed(const Duration(milliseconds: 150));

    try {
      final response = await http.post(Uri.parse(autofocusUrl));
      if (response.statusCode != 200 && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to autofocus: ${response.body}")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      // Ensure we reset the button state
      if (mounted) {
        setState(() {
          isShutterPressed = false;
        });
      }
    }
  }

  // Fixed method to prevent UI shaking
  Future<void> _toggleRecording() async {
    const recordUrl = 'http://127.0.0.1:5000/record';

    setState(() {
      isShutterPressed = true;
    });

    // Small delay to show button press animation
    await Future.delayed(const Duration(milliseconds: 150));

    try {
      final response = await http.post(
        Uri.parse(recordUrl),
        body: {'action': isRecording ? 'stop' : 'start'},
      );

      if (response.statusCode == 200 && mounted) {
        setState(() {
          isRecording = !isRecording;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Recording error: $e")));
      }
    } finally {
      if (mounted) {
        setState(() {
          isShutterPressed = false;
        });
      }
    }
  }

  void _toggleGreenFilter() {
    setState(() {
      isGreenFilterActive = !isGreenFilterActive;
    });

    // Feedback without SnackBar to prevent shaking
    // You could implement a custom overlay here instead
  }

  void _openGallery() {
    // Simple state change without SnackBar
    // In a real app, you would navigate to the gallery screen
  }

  void _openViaOptions() {
    // Simple state change without SnackBar
    // In a real app, you would show a dialog with options
  }

  @override
  Widget build(BuildContext context) {
    const streamUrl = 'http://127.0.0.1:5000/video_feed';

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Camera feed
          Positioned.fill(child: WebViewStream(url: streamUrl)),

          // Green filter overlay when active
          if (isGreenFilterActive)
            Positioned.fill(
              child: Container(color: Colors.green.withOpacity(0.2)),
            ),

          // Flash effect overlay - Fixed implementation
          if (showFlash && _flashOpacityAnimation != null)
            AnimatedBuilder(
              animation: _flashAnimationController,
              builder: (context, child) {
                return Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(
                      _flashOpacityAnimation!.value,
                    ),
                  ),
                );
              },
            ),

          // Top controls - minimalist row with icons
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                // Center controls with minimal feedback to prevent shaking
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.wb_sunny_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_in, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
                // Spacer for symmetry
                const SizedBox(width: 56),
              ],
            ),
          ),

          // Bottom controls
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Mode selector (Photo/Video) - Segmented Control Style
                Container(
                  width: 180,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      // Photo Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isPhoto = true),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isPhoto ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Photo',
                              style: TextStyle(
                                color: isPhoto ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Video Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => isPhoto = false),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  !isPhoto ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Video',
                              style: TextStyle(
                                color: !isPhoto ? Colors.black : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Camera controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Green button with feedback
                    GestureDetector(
                      onTap: _toggleGreenFilter,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color:
                              isGreenFilterActive
                                  ? Colors.green.shade300
                                  : Colors.green,
                          shape: BoxShape.circle,
                          border:
                              isGreenFilterActive
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                        ),
                      ),
                    ),
                    // Shutter button with more stable animation
                    GestureDetector(
                      onTap:
                          isPhoto
                              ? () => _triggerAutofocus(context)
                              : _toggleRecording,
                      child: Container(
                        width: isShutterPressed ? 65 : 70,
                        height: isShutterPressed ? 65 : 70,
                        decoration: BoxDecoration(
                          color:
                              isRecording && !isPhoto
                                  ? Colors.red
                                  : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: isShutterPressed ? 3 : 5,
                          ),
                        ),
                        child:
                            isRecording && !isPhoto
                                ? Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                )
                                : null,
                      ),
                    ),
                    // VIA button
                    GestureDetector(
                      onTap: _openViaOptions,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'VIA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Menu/gallery button
                    GestureDetector(
                      onTap: _openGallery,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.grid_view,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
