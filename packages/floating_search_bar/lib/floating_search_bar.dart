import 'dart:async';

import 'package:flutter/services.dart';

class FloatingSearchBar {
  static const MethodChannel _channel =
      const MethodChannel('floating_search_bar');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
