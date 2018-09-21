import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class FlutterMidi {
  static const MethodChannel _channel = MethodChannel('flutter_midi');
  static Future<String> prepare() async {
    final String result = await _channel.invokeMethod('prepare_midi');
    return result;
  }

  static Future<String> playMidiNote({
    @required int midi,
  }) async {
    final Map<dynamic, dynamic> mapData = <dynamic, dynamic>{};
    print("Pressed: $midi");
    mapData["note"] = midi;
    final String result =
        await _channel.invokeMethod('play_midi_note', mapData);
    return result;
  }
}
