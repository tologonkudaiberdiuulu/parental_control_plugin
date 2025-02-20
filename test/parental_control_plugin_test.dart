import 'package:flutter_test/flutter_test.dart';
import 'package:parental_control_plugin/parental_control_plugin.dart';
import 'package:parental_control_plugin/parental_control_plugin_platform_interface.dart';
import 'package:parental_control_plugin/parental_control_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockParentalControlPluginPlatform
    with MockPlatformInterfaceMixin
    implements ParentalControlPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ParentalControlPluginPlatform initialPlatform = ParentalControlPluginPlatform.instance;

  test('$MethodChannelParentalControlPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelParentalControlPlugin>());
  });

  test('getPlatformVersion', () async {
    ParentalControlPlugin parentalControlPlugin = ParentalControlPlugin();
    MockParentalControlPluginPlatform fakePlatform = MockParentalControlPluginPlatform();
    ParentalControlPluginPlatform.instance = fakePlatform;

    expect(await parentalControlPlugin.getPlatformVersion(), '42');
  });
}
