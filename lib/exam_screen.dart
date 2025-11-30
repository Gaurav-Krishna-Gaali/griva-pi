import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'gallery_screen.dart';
import 'config/app_config.dart';

class PiCameraScreen extends StatefulWidget {
  const PiCameraScreen({super.key});

  @override
  State<PiCameraScreen> createState() => _PiCameraScreenState();
}

class _PiCameraScreenState extends State<PiCameraScreen>
    with SingleTickerProviderStateMixin {
  bool isShutterPressed = false;
  bool isGreenFilterActive = false;
  bool showFlash = false;
  Uint8List? capturedImageBytes;

  // New control states
  bool isFlashlightOn = false;
  bool isBrightnessControlVisible = false;
  bool isGreenFilterControlVisible = false;
  bool isZoomControlVisible = false;
  bool isControlsDisabled = false;
  double brightnessLevel = 0.0; // 0.0 to 1.0 (maps to LED stages 0-5)
  double greenFilterLevel = 0.0; // 0.0 to 1.0 (maps to green filter levels 0-5)
  double zoomLevel = 1.0; // 1.0 to 5.0

  // Add list to store captured images
  final List<Uint8List> capturedImages = [];

  // Cache for unlinked images
  final List<Map<String, dynamic>> unlinkedImages =
      []; // {bytes, metadata, timestamp}

  // Timer variables
  Timer? _viaTimer;
  int _viaTimerSeconds = 60;
  bool _isViaTimerRunning = false;

  // Audio player for timer sounds
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Animation controller declared but initialized in initState
  late AnimationController _flashAnimationController;
  Animation<double>? _flashOpacityAnimation;

  // Socket.IO client
  IO.Socket? _socket;
  bool _isSocketConnected = false;
  List<Map<String, dynamic>> _socketMessages = []; // {message, timestamp, type}
  bool _isDisposed = false; // Flag to prevent state updates after dispose
  BuildContext? _currentContext; // Store context for Socket.IO triggered actions

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

    // Initialize LED to stage 0
    _initializeLED();

    // Connect to Socket.IO server
    _connectSocket();
  }

  // Initialize LED to stage 0
  Future<void> _initializeLED() async {
    try {
      final response = await http.post(Uri.parse(AppConfig.ledStageUrl(0)));
      
      if (response.statusCode == 200) {
        print('LED initialized to stage 0');
      } else {
        print('Failed to initialize LED: ${response.statusCode}');
      }
    } catch (e) {
      print('Error initializing LED: $e');
    }
  }

  // Connect to Socket.IO server
  void _connectSocket() {
    try {
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('🔧 [WebSocket] Initializing connection...');
      print('   URL: ${AppConfig.socketIoUrl}');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      
      _socket = IO.io(
        AppConfig.socketIoUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build(),
      );

      print('✓ [WebSocket] Socket instance created');
      print('✓ [WebSocket] Setting up event listeners...');

      // Listen for ANY event FIRST (before specific listeners) to catch everything
      _socket!.onAny((event, data) {
        final timestamp = DateTime.now().toIso8601String();
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('🎯 [WebSocket] onAny() - EVENT DETECTED');
        print('   Event Name: "$event"');
        print('   Timestamp: $timestamp');
        print('   Data Type: ${data.runtimeType}');
        print('   Data: $data');
        print('   Data (String): ${data.toString()}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        
        // Handle system events
        if (event == 'connect') {
          // Handled by onConnect
          return;
        } else if (event == 'disconnect') {
          // Handled by onDisconnect
          return;
        } else if (event == 'error') {
          // Handled by onError
          return;
        } else {
          // Handle all other events (including 'message', 'notification', etc.)
          _handleSocketMessage(data, event);
        }
      });

      _socket!.onConnect((_) {
        final timestamp = DateTime.now().toIso8601String();
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('🔌 [WebSocket] CONNECTED at $timestamp');
        print('   URL: ${AppConfig.socketIoUrl}');
        print('   Socket ID: ${_socket?.id ?? 'N/A'}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        if (!_isDisposed && mounted) {
          try {
            setState(() {
              _isSocketConnected = true;
            });
          } catch (e) {
            print('❌ Error updating state on connect: $e');
          }
        }
      });

      _socket!.onDisconnect((_) {
        final timestamp = DateTime.now().toIso8601String();
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('🔌 [WebSocket] DISCONNECTED at $timestamp');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        if (!_isDisposed && mounted) {
          try {
            setState(() {
              _isSocketConnected = false;
            });
          } catch (e) {
            print('❌ Error updating state on disconnect: $e');
          }
        }
      });

      _socket!.onError((error) {
        final timestamp = DateTime.now().toIso8601String();
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        print('❌ [WebSocket] ERROR at $timestamp');
        print('   Error: $error');
        print('   Error Type: ${error.runtimeType}');
        print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      });

      // Listen for specific message event (in case server sends with 'message' event name)
      _socket!.on('message', (data) {
        print('📨 [WebSocket] Received "message" event (specific listener)');
        _handleSocketMessage(data, 'message');
      });

      // Listen for notification event
      _socket!.on('notification', (data) {
        print('🔔 [WebSocket] Received "notification" event (specific listener)');
        _handleSocketMessage(data, 'notification');
      });

      print('✓ [WebSocket] All listeners set up');
      print('✓ [WebSocket] Attempting to connect...');
      
      // Connect manually after setting up listeners
      _socket!.connect();
    } catch (e, stackTrace) {
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      print('❌ [WebSocket] Error connecting to Socket.IO');
      print('   Error: $e');
      print('   StackTrace: $stackTrace');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    }
  }

  void _handleSocketMessage(dynamic data, String eventType) {
    final timestamp = DateTime.now().toIso8601String();
    final messageStr = data.toString().toLowerCase().trim();
    
    // Log message details to console
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('📩 [WebSocket] MESSAGE RECEIVED');
    print('   Event Type: $eventType');
    print('   Timestamp: $timestamp');
    print('   Data Type: ${data.runtimeType}');
    print('   Data: $data');
    print('   Data (String): ${data.toString()}');
    
    // Check if message is "capture" to trigger image capture
    if (messageStr == 'capture' || messageStr.contains('capture')) {
      print('   ⚡ CAPTURE TRIGGER DETECTED!');
      print('   → Triggering camera capture...');
      if (!_isDisposed && mounted && _currentContext != null) {
        _captureImage(_currentContext!);
        print('   ✓ Capture function called');
      } else {
        print('   ⚠️  Cannot capture: disposed=${_isDisposed}, mounted=$mounted, context=${_currentContext != null}');
      }
    }
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    
    if (!_isDisposed && mounted) {
      try {
        setState(() {
          _socketMessages.insert(0, {
            'message': data.toString(),
            'timestamp': DateTime.now(),
            'type': eventType,
          });
          // Keep only last 50 messages
          if (_socketMessages.length > 50) {
            _socketMessages.removeLast();
          }
        });
      } catch (e) {
        print('❌ Error updating state on message: $e');
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true; // Mark as disposed to prevent state updates
    
    // Remove all socket listeners before disconnecting
    _socket?.clearListeners();
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    
    _flashAnimationController.dispose();
    _viaTimer?.cancel();
    _audioPlayer.dispose();
    // Turn off LED when screen is disposed
    _turnOffLED();
    super.dispose();
  }

  // Turn off LED
  Future<void> _turnOffLED() async {
    try {
      await http.post(Uri.parse(AppConfig.ledStageUrl(0)));
      print('LED turned off');
    } catch (e) {
      print('Error turning off LED: $e');
    }
  }

  // Green filter control (slider for fine control)
  void _toggleGreenFilterControl() {
    setState(() {
      isGreenFilterControlVisible = !isGreenFilterControlVisible;
      if (isGreenFilterControlVisible) {
        isBrightnessControlVisible = false; // Close brightness if open
        isZoomControlVisible = false; // Close zoom if open
      }
    });
  }

  // Update green filter level and control API
  Future<void> _updateGreenFilter(double value) async {
    setState(() {
      greenFilterLevel = value;
    });

    // Map green filter level (0.0-1.0) to levels (0-5)
    int filterLevel = (value * 5).round();

    await _setGreenFilterLevel(filterLevel);
  }

  // Set green filter level
  Future<void> _setGreenFilterLevel(int level) async {
    try {
      final response = await http.post(Uri.parse(AppConfig.greenFilterUrl(level)));
      
      if (response.statusCode == 200) {
        print('Green filter level set to $level successfully');
      } else {
        print('Failed to set green filter level: ${response.statusCode}');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Green filter control failed: ${response.body}"),
            ),
          );
        }
      }
    } catch (e) {
      print('Error controlling green filter: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Green filter error: $e")));
      }
    }
  }

  void _openGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => GalleryScreen(
              images: capturedImages,
              unlinkedImages: unlinkedImages,
              onDelete: (index) {
                setState(() {
                  capturedImages.removeAt(index);
                });
              },
            ),
      ),
    );
  }

  // Brightness control (slider for fine LED control)
  void _toggleBrightnessControl() {
    setState(() {
      isBrightnessControlVisible = !isBrightnessControlVisible;
      if (isBrightnessControlVisible) {
        isGreenFilterControlVisible = false; // Close green filter if open
        isZoomControlVisible = false; // Close zoom if open
      }
    });
  }

  // Update brightness level and control LED
  Future<void> _updateBrightness(double value) async {
    setState(() {
      brightnessLevel = value;
    });

    // Map brightness level (0.0-1.0) to LED stages (0-5)
    int ledStage = (value * 5).round();

    await _setLEDStage(ledStage);
  }

  // Set LED stage
  Future<void> _setLEDStage(int stage) async {
    try {
      final response = await http.post(Uri.parse(AppConfig.ledStageUrl(stage)));
      
      if (response.statusCode == 200) {
        print('LED stage set to $stage successfully');
      } else {
        print('Failed to set LED stage: ${response.statusCode}');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("LED control failed: ${response.body}")),
          );
        }
      }
    } catch (e) {
      print('Error controlling LED: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("LED error: $e")));
      }
    }
  }

  // Zoom control
  void _toggleZoomControl() {
    setState(() {
      isZoomControlVisible = !isZoomControlVisible;
      if (isZoomControlVisible) {
        isBrightnessControlVisible = false; // Close brightness if open
        isGreenFilterControlVisible = false; // Close green filter if open
      }
    });
  }

  // Update zoom level
  void _updateZoom(double value) {
    setState(() {
      zoomLevel = value;
    });
  }

  // Add new capture method
  Future<void> _captureImage(BuildContext context) async {
    final captureUrl = AppConfig.captureUrl;

    setState(() {
      isShutterPressed = true;
      showFlash = true;
    });

    if (mounted) {
      _flashAnimationController.reset();
      _flashAnimationController.forward();
    }

    await Future.delayed(const Duration(milliseconds: 150));

    try {
      final response = await http.get(Uri.parse(captureUrl));
      if (response.statusCode == 200 && mounted) {
        setState(() {
          // Store the raw bytes directly and add to stack
          capturedImageBytes = response.bodyBytes;
          capturedImages.add(response.bodyBytes);
        });

        // Store image in cache with metadata
        await _cacheImage(response.bodyBytes);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to capture image: ${response.body}")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) {
        setState(() {
          isShutterPressed = false;
        });
      }
    }
  }

  // Cache image temporarily
  Future<void> _cacheImage(Uint8List imageBytes) async {
    try {
      // Create metadata for the image
      final metadata = {
        'timestamp': DateTime.now().toIso8601String(),
        'led_stage': (brightnessLevel * 5).round(),
        'green_filter_level': (greenFilterLevel * 5).round(),
        'zoom_level': zoomLevel,
        'capture_settings': {
          'brightness': brightnessLevel,
          'green_filter': greenFilterLevel,
          'zoom': zoomLevel,
        },
      };

      // Add to unlinked images cache
      unlinkedImages.add({
        'bytes': imageBytes,
        'metadata': metadata,
        'timestamp': DateTime.now(),
      });

      print(
        'Image cached successfully. Total unlinked images: ${unlinkedImages.length}',
      );
    } catch (e) {
      print('Error caching image: $e');
    }
  }

  // Start or stop VIA timer
  void _toggleViaTimer() async {
    if (_isViaTimerRunning) {
      // Stop timer
      _viaTimer?.cancel();
      setState(() {
        _isViaTimerRunning = false;
        _viaTimerSeconds = 60;
      });

      // Play stop sound
      try {
        print('Playing stop sound...');
        await _audioPlayer.play(AssetSource('audio/timer_stop.mp3'));
        print('Stop sound played successfully');
      } catch (e) {
        print('Error playing stop sound: $e');
      }
    } else {
      // Start timer
      setState(() {
        _isViaTimerRunning = true;
        _viaTimerSeconds = 60;
      });

      // Play start sound
      try {
        print('Playing start sound...');
        await _audioPlayer.play(AssetSource('audio/timer_start.mp3'));
        print('Start sound played successfully');
      } catch (e) {
        print('Error playing start sound: $e');
      }

      _viaTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            if (_viaTimerSeconds > 0) {
              _viaTimerSeconds--;
            } else {
              _isViaTimerRunning = false;
              timer.cancel();

              // Play completion sound
              _audioPlayer
                  .play(AssetSource('audio/timer_complete.mp3'))
                  .then((_) {
                    print('Completion sound played successfully');
                  })
                  .catchError((e) {
                    print('Error playing completion sound: $e');
                  });
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Store context for Socket.IO triggered actions
    _currentContext = context;
    
    final streamUrl = AppConfig.mjpegStreamUrl;
    // final streamUrl = AppConfig.altCamUrl;
    // final streamUrl = AppConfig.videoFeedUrl;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Camera feed with pinch-to-zoom
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: FittedBox(
                fit: BoxFit.cover,
                child: InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 5.0,
                  panEnabled: !isControlsDisabled,
                  scaleEnabled: !isControlsDisabled,
                  child: Transform.scale(
                    scale: zoomLevel,
                    child: WebViewStream(url: streamUrl),
                  ),
                ),
              ),
            ),
          ),

          // Green filter overlay when active
          if (isGreenFilterActive)
            Positioned.fill(
              child: Container(color: Colors.green.withOpacity(0.2)),
            ),

          // Flashlight overlay when active
          if (isFlashlightOn)
            Positioned.fill(
              child: Container(color: Colors.white.withOpacity(0.1)),
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
                    // LED control button (flashlight icon)
                    // IconButton(
                    //   icon: Icon(
                    //     isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
                    //     color: isFlashlightOn ? Colors.yellow : Colors.white,
                    //   ),
                    //   onPressed: isControlsDisabled ? null : _toggleLED,
                    //   tooltip: 'LED Light',
                    // ),
                    // Unlinked images indicator
                    if (unlinkedImages.isNotEmpty)
                      Stack(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.image, color: Colors.orange),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${unlinkedImages.length} images ready to link in gallery',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            tooltip: '${unlinkedImages.length} unlinked images',
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${unlinkedImages.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    // LED brightness control button (flash icon)
                    IconButton(
                      icon: Icon(
                        Icons.wb_sunny,
                        color: isBrightnessControlVisible ? Colors.yellow : Colors.white,
                      ),
                      onPressed: isControlsDisabled ? null : _toggleBrightnessControl,
                      tooltip: 'LED Brightness',
                    ),
                    // Zoom control button
                    IconButton(
                      icon: Icon(
                        Icons.zoom_in,
                        color:
                            isZoomControlVisible ? Colors.yellow : Colors.white,
                      ),
                      onPressed: isControlsDisabled ? null : _toggleZoomControl,
                      tooltip: 'Zoom',
                    ),
                    // Toggle controls on/off button
                    // IconButton(
                    //   icon: Icon(
                    //     isControlsDisabled ? Icons.block : Icons.toggle_on,
                    //     color: isControlsDisabled ? Colors.red : Colors.white,
                    //   ),
                    //   onPressed: _toggleControlsDisabled,
                    //   tooltip: isControlsDisabled ? 'Enable Controls' : 'Disable Controls',
                    // ),
                    // Compare images button
                    // IconButton(
                    //   icon: const Icon(Icons.compare, color: Colors.white),
                    //   onPressed: isControlsDisabled ? null : (capturedImages.isNotEmpty ? _openComparison : null),
                    //   tooltip: 'Compare Images',
                    // ),
                    // Test audio button
                    // IconButton(
                    //   icon: const Icon(Icons.volume_up, color: Colors.white),
                    //   onPressed: isControlsDisabled ? null : _testAudio,
                    //   tooltip: 'Test Audio',
                    // ),
                  ],
                ),
                // Spacer for symmetry
                const SizedBox(width: 56),
              ],
            ),
          ),

          // LED brightness control panel
          if (isBrightnessControlVisible)
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'LED Brightness',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.brightness_low, color: Colors.white),
                        Expanded(
                          child: Slider(
                            value: brightnessLevel,
                            min: 0.0,
                            max: 1.0,
                            activeColor: Colors.yellow,
                            inactiveColor: Colors.grey,
                            onChanged: _updateBrightness,
                          ),
                        ),
                        const Icon(Icons.brightness_high, color: Colors.white),
                      ],
                    ),
                    Text(
                      'LED Stage: ${(brightnessLevel * 5).round()}/5 (${(brightnessLevel * 100).round()}%)',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

          // Green filter control panel
          if (isGreenFilterControlVisible)
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Green Filter',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.filter_vintage, color: Colors.white),
                        Expanded(
                          child: Slider(
                            value: greenFilterLevel,
                            min: 0.0,
                            max: 1.0,
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                            onChanged: _updateGreenFilter,
                          ),
                        ),
                        const Icon(Icons.filter_vintage, color: Colors.green),
                      ],
                    ),
                    Text(
                      'Filter Level: ${(greenFilterLevel * 5).round()}/5 (${(greenFilterLevel * 100).round()}%)',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

          // Zoom control panel
          if (isZoomControlVisible)
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Zoom',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.zoom_out, color: Colors.white),
                        Expanded(
                          child: Slider(
                            value: zoomLevel,
                            min: 1.0,
                            max: 5.0,
                            activeColor: Colors.blue,
                            inactiveColor: Colors.grey,
                            onChanged: _updateZoom,
                          ),
                        ),
                        const Icon(Icons.zoom_in, color: Colors.white),
                      ],
                    ),
                    Text(
                      '${zoomLevel.toStringAsFixed(1)}x',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

          // Bottom controls
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Photo mode indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Photo Mode',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Timer display inline with toggle
                    if (_isViaTimerRunning) ...[
                      const SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '$_viaTimerSeconds',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 30),
                // Camera controls - centered
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Green filter control button
                    GestureDetector(
                      onTap: _toggleGreenFilterControl,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color:
                              isGreenFilterControlVisible
                                  ? Colors.green.shade300
                                  : Colors.green,
                          shape: BoxShape.circle,
                          border:
                              isGreenFilterControlVisible
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    // Shutter button for photo capture
                    GestureDetector(
                      onTap: () => _captureImage(context),
                      child: Container(
                        width: isShutterPressed ? 65 : 70,
                        height: isShutterPressed ? 65 : 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: isShutterPressed ? 3 : 5,
                          ),
                        ),
                        child: Icon(
                          Icons.camera,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    // VIA button
                    GestureDetector(
                      onTap: _toggleViaTimer,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color:
                              _isViaTimerRunning
                                  ? Colors.red.withOpacity(0.8)
                                  : Colors.grey.withOpacity(0.5),
                          shape: BoxShape.circle,
                          border:
                              _isViaTimerRunning
                                  ? Border.all(color: Colors.white, width: 2)
                                  : null,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'VIA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
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

          // Add preview of captured image if available
          if (capturedImageBytes != null)
            Positioned(
              top: 100,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    capturedImageBytes = null;
                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(capturedImageBytes!, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),

          // Socket.IO Messages Display
          if (_socketMessages.isNotEmpty)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: _buildSocketMessagesWidget(),
            ),

          // Socket.IO Connection Status Indicator
          Positioned(
            top: 100,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _isSocketConnected 
                    ? Colors.green.withOpacity(0.8)
                    : Colors.red.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isSocketConnected ? Icons.wifi : Icons.wifi_off,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _isSocketConnected ? 'Connected' : 'Disconnected',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocketMessagesWidget() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[900]?.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.message, color: Colors.orange, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Messages (${_socketMessages.length})',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      _socketMessages.clear();
                    });
                  },
                ),
              ],
            ),
          ),
          // Messages List
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              reverse: false,
              itemCount: _socketMessages.length > 10 ? 10 : _socketMessages.length,
              itemBuilder: (context, index) {
                final message = _socketMessages[index];
                final timestamp = message['timestamp'] as DateTime;
                final messageText = message['message'] as String;
                final eventType = message['type'] as String;
                
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800]?.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              eventType,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        messageText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
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
