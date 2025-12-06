import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_settings_plus/open_settings_plus.dart';

enum NetworkType { wifi, bluetooth, mobileData }

class NetworkService {
  static Future<bool> openSpecificNetworkSettings(NetworkType type) async {
    try {
      if (!Platform.isAndroid && !Platform.isIOS) {
        return false;
      }

      final shared = OpenSettingsPlus.shared;
      switch (type) {
        case NetworkType.wifi:
          if (shared is OpenSettingsPlusAndroid) {
            await shared.wifi();
          } else if (shared is OpenSettingsPlusIOS) {
            await shared.wifi();
          } else {
            return false;
          }
          break;
        case NetworkType.bluetooth:
          if (shared is OpenSettingsPlusAndroid) {
            await shared.bluetooth();
          } else if (shared is OpenSettingsPlusIOS) {
            await shared.bluetooth();
          } else {
            return false;
          }
          break;
        case NetworkType.mobileData:
          if (shared is OpenSettingsPlusAndroid) {
            // await shared.mobileData();
          } else {
            return false;
          }
          break;
      }
      return true;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('Failed to open settings: $e');
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}


