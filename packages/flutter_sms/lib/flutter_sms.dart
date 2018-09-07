import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlutterSms {
  static const MethodChannel _channel = MethodChannel('flutter_sms');

  static Future<String> sendSMS({
    @required String message,
    @required List<String> recipients,
  }) async {
    final Map<dynamic, dynamic> mapData = <dynamic, dynamic>{};
    mapData["message"] = message;
    mapData["recipients"] = recipients;
    final String result = await _channel.invokeMethod('sendSMS', mapData);
    return result;
  }
}
