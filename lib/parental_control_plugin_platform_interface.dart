import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'parental_control_plugin_method_channel.dart';

abstract class ParentalControlPluginPlatform extends PlatformInterface {
  /// Constructs a ParentalControlPluginPlatform.
  ParentalControlPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static ParentalControlPluginPlatform _instance = MethodChannelParentalControlPlugin();

  /// The default instance of [ParentalControlPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelParentalControlPlugin].
  static ParentalControlPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ParentalControlPluginPlatform] when
  /// they register themselves.
  static set instance(ParentalControlPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
