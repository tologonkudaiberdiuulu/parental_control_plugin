import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'parental_control_plugin_platform_interface.dart';

/// An implementation of [ParentalControlPluginPlatform] that uses method channels.
class MethodChannelParentalControlPlugin extends ParentalControlPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('parental_control_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
