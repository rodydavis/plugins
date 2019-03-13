import 'dart:async';

import 'package:flutter/services.dart';

class ResponsiveScaffold {
  static const MethodChannel _channel =
      const MethodChannel('responsive_scaffold');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
