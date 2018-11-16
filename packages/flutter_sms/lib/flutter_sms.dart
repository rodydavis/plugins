import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterSms {
  static const MethodChannel _channel = const MethodChannel('flutter_sms');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> sendSMS({
    @required String message,
    @required List<String> recipients,
  }) async {
    var mapData = Map<dynamic, dynamic>();
    mapData["message"] = message;
    mapData["recipients"] = recipients;
    final String result = await _channel.invokeMethod('sendSMS', mapData);
    // String _log = "SMS Message: $message";
    // for (var person in recipients) _log += "\nSent: $person";
    // final String result = _log;
    return result;
  }
}
