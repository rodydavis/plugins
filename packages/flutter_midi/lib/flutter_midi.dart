import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'local_storage.dart';

class FlutterMidi {
  static const MethodChannel _channel = MethodChannel('flutter_midi');

  /// Needed so that the sound font is loaded
  /// On iOS make sure to include the sound_font.SF2 in the Runner folder.
  /// This does not work in the simulator.
  static Future<String> prepare(
      {@required ByteData sf2, String name = "instrument.sf2"}) async {
    File _file = await writeToFile(sf2, name: name);

    final Map<dynamic, dynamic> mapData = <dynamic, dynamic>{};
    mapData["path"] = _file.path;
    print("Path => ${_file.path}");
    final String result = await _channel.invokeMethod('prepare_midi', mapData);
    print("Result: $result");
    return result;
  }

  /// Needed so that the sound font is loaded
  /// On iOS make sure to include the sound_font.SF2 in the Runner folder.
  /// This does not work in the simulator.
  static Future<String> changeSound(
      {@required ByteData sf2, String name = "instrument.sf2"}) async {
    File _file = await writeToFile(sf2, name: name);

    final Map<dynamic, dynamic> mapData = <dynamic, dynamic>{};
    mapData["path"] = _file.path;
    print("Path => ${_file.path}");
    final String result = await _channel.invokeMethod('change_sound', mapData);
    print("Result: $result");
    return result;
  }

  /// Unmute the device temporarly even if the mute switch is on or toggled in settings.
  static Future<String> unmute() async {
    final String result = await _channel.invokeMethod('unmute');
    return result;
  }

  /// Use this when stopping the sound onTouchUp or to cancel a long file.
  /// Not needed if playing midi onTap.
  static Future<String> stopMidiNote({
    @required int midi,
  }) async {
    final Map<dynamic, dynamic> mapData = <dynamic, dynamic>{};
    print("Pressed: $midi");
    mapData["note"] = midi;
    final String result =
        await _channel.invokeMethod('stop_midi_note', mapData);
    return result;
  }

  /// Play a midi note from the sound_font.SF2 library bundled with the application.
  /// Play a midi note in the range between 0-256
  /// Multiple notes can be played at once as seperate calls.
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
