class AppConfig {
  // Base IP/host for the camera/control server
  // static const String baseHost = '192.168.1.54';
  static const String baseHost = '127.0.0.1';
  static const int httpPort = 5000;

  // Derived base URL
  static String get baseUrl => 'http://$baseHost:$httpPort';

  // Camera/control endpoints
  static String ledStageUrl(int stage) => '$baseUrl/led?stage=$stage';
  static String greenFilterUrl(int level) => '$baseUrl/green?level=$level';
  static String get captureUrl => '$baseUrl/capture';

  // Streaming endpoints (choose one as needed)
  static String get mjpegStreamUrl => 'http://$baseHost:$httpPort/?action=stream';
  static String get videoFeedUrl => '$baseUrl/video_feed';
  static String get altCamUrl => 'http://$baseHost:8889/cam1/';

  // Inference endpoint
  static String get inferUrl => '$baseUrl/infer';
}


