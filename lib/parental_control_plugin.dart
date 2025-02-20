import 'package:flutter/services.dart';

import 'parental_control_plugin_platform_interface.dart';

class ParentalControlPlugin {
  static const MethodChannel _channel = MethodChannel(
    'parental_control_plugin',
  );

  Future<String?> getPlatformVersion() {
    return ParentalControlPluginPlatform.instance.getPlatformVersion();
  }

  static Future<bool> blockApp(String packageName) async {
    final bool success = await _channel.invokeMethod('blockApp', {
      'packageName': packageName,
    });
    return success;
  }

  static Future<bool> unblockApp(String packageName) async {
    final bool success = await _channel.invokeMethod('unblockApp', {
      'packageName': packageName,
    });
    return success;
  }

  static Future<bool> showQuizDialog(String packageName) async {
    final bool success = await _channel.invokeMethod('showQuizDialog', {
      'packageName': packageName,
    });
    return success;
  }

  static Future<bool> logActionToFirebase(
    String action,
    String packageName,
  ) async {
    final bool success = await _channel.invokeMethod('logActionToFirebase', {
      'action': action,
      'packageName': packageName,
    });
    return success;
  }

  static Future<bool> enableDeviceAdmin() async {
    final bool success = await _channel.invokeMethod('enableDeviceAdmin');
    return success;
  }
}
