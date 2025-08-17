class AppVersion {
  // Update this version number when pushing new Shorebird patches
  static const String version = '1.0.0';
  static const String buildNumber = '1';
  
  // Get full version string
  static String get fullVersion => 'v$version+$buildNumber';
  
  // Get short version string
  static String get shortVersion => 'v$version';
}
